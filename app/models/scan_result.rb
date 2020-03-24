# frozen_string_literal: true

class ScanResult < ApplicationRecord
  require 'socket'

  include OrganizationAssociated
  include ScanResult::Ransackers
  include Legalitiable

  COLORS = ['#228B22', '#DAA520', '#DC143C'].freeze

  enum state: %i[closed closed_filtered filtered unfiltered open_filtered open]
  serialize :vulns, Hash

  before_save :set_source_ip, :set_engine

  validates :scan_job_id, numericality: { only_integer: true }
  validates :start, presence: true
  validates :finished, presence: true
  validates :ip, presence: true
  validates :port, inclusion: { in: 0..65535 }
  validates :state, inclusion: { in: ScanResult.states.keys}

  belongs_to :scan_job

  # TODO: Its seems wrnog, delete if not used
  #belongs_to :host_service, foreign_key: :ip, optional: true

  has_one :organization, through: :scan_job

  def host_service
    HostService.first.where(ip: ip, port: port, protocol: protocol)
  end

  def organization_id
    scan_job.organization_id
  end

  def state_color
    self.class.state_to_color self.class.states[state]
  end

  def self.state_to_color code
    if code == 0
      COLORS[code]
    elsif code == 5
      COLORS[2]
    else
      COLORS[1]
    end
  end

  def self.human_attribute_states
    Hash[ScanResult.states.map { |k,v| [v, ScanResult.human_enum_name(:state, k)] }]
  end

  private

  def set_source_ip
    external_ip = ExternalIP.new.run
    if external_ip.present?
      self.source_ip = external_ip
    end
  end

  def set_engine
    self.scan_engine = self.scan_job.scan_engine
  end
end
