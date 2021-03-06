# frozen_string_literl: true
module Right::SubjectTypes
  SUBJECT_TYPES = {
    'Organization' => I18n.t('activerecord.models.organization.one'),
    'OrganizationKind' =>  I18n.t('activerecord.models.organization_kind.one'),
    'User' => I18n.t('activerecord.models.user.one'),
    'Department' => I18n.t('activerecord.models.department.one'),
    'Agreement' => I18n.t('activerecord.models.agreement.one'),
    'AgreementKind' => I18n.t('activerecord.models.agreement_kind.one'),
    'Article' => I18n.t('activerecord.models.article.one'),
    'ArticlesFolder' => I18n.t('activerecord.models.articles_folder.one'),
    'Incident' => I18n.t('activerecord.models.incident.one'),
    'Investigation' => I18n.t('activerecord.models.investigation.one'),
    'InvestigationKind' => I18n.t('activerecord.models.investigation_kind.one'),
    'Feed' => I18n.t('activerecord.models.feed.one'),
    'Indicator' => I18n.t('activerecord.models.indicator.one'),
    'IndicatorContext' => I18n.t('activerecord.models.indicator_context.one'),
    'Enrichment' => I18n.t('activerecord.models.enrichment.one'),
    'Host' => I18n.t('activerecord.models.host.one'),
    'HostService' => I18n.t('activerecord.models.host_service.one'),
    'HostServiceStatus' => I18n.t('activerecord.models.host_service_status.one'),
    'ScanOption' => I18n.t('activerecord.models.scan_option.one'),
    'ScanJob' => I18n.t('activerecord.models.scan_job.one'),
    'ScanJobLog' => I18n.t('activerecord.models.scan_job_log.one'),
    'ScanJobsHost' => I18n.t('activerecord.models.scan_jobs_host.one'),
    'ScanResult' => I18n.t('activerecord.models.scan_result.one'),
    'Schedule' => I18n.t('activerecord.models.schedule.one'),
    'ScheduledJobs' => I18n.t('activerecord.models.scheduled_jobs.one'),
    'Agent' => I18n.t('activerecord.models.agent.one'),
    'RaAgentApi' => I18n.t('labels.ra_agent_api'),
    'Vulnerability' => I18n.t('activerecord.models.vulnerability.one'),
    'VulnerabilityKind' => I18n.t('activerecord.models.vulnerability_kind.one'),
    'VulnerabilityBulletin' => I18n.t('activerecord.models.vulnerability_bulletin.one'),
    'VulnerabilityBulletinKind' => I18n.t('activerecord.models.vulnerability_bulletin_kind.one'),
    'VulnerabilityBulletinMember' => I18n.t('activerecord.models.vulnerability_bulletin_member.one'),
    'VulnerabilityBulletinStatus' => I18n.t('activerecord.models.vulnerability_bulletin_status.one'),
    'DeliveryList' => I18n.t('activerecord.models.delivery_list.one'),
    'DeliverySubject' => I18n.t('activerecord.models.delivery_subject.one'),
    'DeliveryRecipient' => I18n.t('activerecord.models.delivery_recipient.one'),
    'Subscription' => I18n.t('activerecord.models.subscription.one'),
    'Publication' => I18n.t('activerecord.models.publication.one'),
    'ProcessingLog' => I18n.t('activerecord.models.processing_log.one'),
    'NotificationsLog' => I18n.t('activerecord.models.notifications_log.one'),
    'SearchFilter' => I18n.t('activerecord.models.search_filter.one'),
    'AttachedFile' => I18n.t('activerecord.models.attached_file.one'),
    'Tag' => I18n.t('activerecord.models.tag.one'),
    'TagKind' => I18n.t('activerecord.models.tag_kind.one'),
    'TagMember' => I18n.t('activerecord.models.tag_member.one'),
    'Link' => I18n.t('activerecord.models.link.one'),
    'LinkKind' => I18n.t('activerecord.models.link_kind.one'),
    'RecordTemplate' => I18n.t('activerecord.models.record_template.one'),
    'Versions' => I18n.t('labels.version.versions'),
    'Reports' => I18n.t('labels.reports'),
    'CustomReportsFolder' => I18n.t('activerecord.models.custom_reports_folder.one'),
    'CustomReport' => I18n.t('activerecord.models.custom_report.one'),
    'CustomReportsResult' => I18n.t('activerecord.models.custom_reports_result.one'),
    'Charts' => I18n.t('navigations.charts'),
    'Dashboards' => I18n.t('navigations.dashboards'),
    'ReadableLog' => I18n.t('activerecord.models.readable_log.one')
  }.freeze
end
