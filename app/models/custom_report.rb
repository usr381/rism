class CustomReport < ApplicationRecord
  include OrganizationMember
  include Linkable
  include Tagable
  include Attachable
  include Rightable

  RESULT_FORMATS = {
    csv: 'csv',
    json: 'json'
  }.freeze

  enum result_format: RESULT_FORMATS, _prefix: true

  validates :name, length: { minimum: 3, maximum: 300 }
  validates :name, uniqueness: { scope: :folder_id }
  validates :organization_id, numericality: { only_integer: true }
  validates :folder_id, numericality: { only_integer: true, allow_blank: true }
  validates :result_format, inclusion: { in: CustomReport.result_formats.values }
  validates :statement, presence: true
  validate :statement_danger_commands

  belongs_to :custom_reports_folder, foreign_key: :folder_id, optional: true
  belongs_to :organization
  has_many :custom_reports_results, dependent: :destroy

  def variables_arr
    CustomReportJob::Query.new(custom_report.statement).variables_arr
  end

  private

  def statement_danger_commands
    return unless statement.match? /drop|delete|update|create|alter|grant|load|insert|lock|reindex|set|truncate/i
    errors.add(:statement, 'Danger SQL commands can`t be used!')
  end
end
