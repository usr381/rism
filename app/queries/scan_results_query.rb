class ScanResultsQuery
  def initialize(scope = ScanResult)
    @relation = scope
  end

  def last_results
    @relation.joins(last_results_sql)
  end

  def last_nmap_results
    @relation.joins(last_nmap_results_sql)
  end

  def last_shodan_results
    @relation.joins(last_shodan_results_sql)
  end

  def not_registered_services
    @relation.where(not_registered_services_sql)
  end

  private

  def last_results_sql
    <<~SQL
      INNER JOIN (
        SELECT
          scan_results.ip,
          MAX(scan_results.job_start)
          AS max_time
        FROM scan_results
        GROUP BY scan_results.ip
      )m
      ON scan_results.ip = m.ip
      AND scan_results.job_start = m.max_time
    SQL
  end

  def last_nmap_results_sql
    <<~SQL
      INNER JOIN (
        SELECT
          scan_results.ip,
          MAX(scan_results.job_start)
          AS max_time
        FROM scan_results
        JOIN scan_jobs ON scan_jobs.id = scan_results.scan_job_id
        WHERE scan_jobs.scan_engine = 'nmap'
        GROUP BY scan_results.ip
      )m
      ON scan_results.ip = m.ip
      AND scan_results.job_start = m.max_time
    SQL
  end

  def last_shodan_results_sql
    <<~SQL
      INNER JOIN (
        SELECT
          scan_results.ip,
          MAX(scan_results.job_start)
          AS max_time
        FROM scan_results
        JOIN scan_jobs ON scan_jobs.id = scan_results.scan_job_id
        WHERE scan_jobs.scan_engine = 'shodan'
        GROUP BY scan_results.ip
      )m
      ON scan_results.ip = m.ip
      AND scan_results.job_start = m.max_time
    SQL
  end

  def not_registered_services_sql
    <<~SQL
      NOT EXISTS (
        SELECT null FROM host_services
        INNER JOIN hosts
        ON hosts.ip = scan_results.ip
        WHERE
        host_services.host_id = hosts.id AND
        host_services.port = scan_results.port AND
        host_services.protocol = scan_results.protocol
      )
   SQL
  end
end
