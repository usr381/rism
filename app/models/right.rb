# frozen_string_literal: true

class Right < ApplicationRecord
  include Right::Ransackers

  LEVELS = {
    1 => I18n.t('rights.manager'),
    2 => I18n.t('rights.editor'),
    3 => I18n.t('rights.reader')
  }.freeze

  ACTIONS = {
    manage: 1,
    edit: 2,
    read: 3
  }.freeze

  SUBJECT_TYPES = {
    'Organization' => I18n.t('activerecord.models.organization.one'),
    'User' => I18n.t('activerecord.models.user.one'),
    'Department' => I18n.t('activerecord.models.department.one'),
    'Agreement' => I18n.t('activerecord.models.agreement.one'),
    'AgreementKind' => I18n.t('activerecord.models.agreement_kind.one'),
    'Article' => I18n.t('activerecord.models.article.one'),
    'OrganizationKind' =>  I18n.t('activerecord.models.organization_kind.one'),
    'Attachment' => I18n.t('activerecord.models.attachment.one'),
    'AttachmentLink' => I18n.t('activerecord.models.attachment_link.one'),
    'TagKind' => I18n.t('activerecord.models.tag_kind.one'),
    'Tag' => I18n.t('activerecord.models.tag.one'),
    'TagMember' => I18n.t('activerecord.models.tag_member.one'),
    'Incident' => I18n.t('activerecord.models.incident.one'),
    'Host' => I18n.t('activerecord.models.host.one'),
    'LinkKind' => I18n.t('activerecord.models.link_kind.one'),
    'Link' => I18n.t('activerecord.models.link.one'),
    'RecordTemplate' => I18n.t('activerecord.models.record_template.one'),
    'Versions' => I18n.t('labels.version.versions'),
    'Reports' => I18n.t('labels.reports'),
    'Charts' => I18n.t('navigations.charts'),
    'Dashboards' => I18n.t('navigations.dashboards'),
    'ScanOption' => I18n.t('activerecord.models.scan_option.one'),
    'ScanJob' => I18n.t('activerecord.models.scan_job.one')
  }.freeze

  # TODO: try to make subject_type field transformation
  # (for search with translated model name)

  ransacker :level do
    field_transformation = <<~SQL
      CASE level
      WHEN 1
      THEN '#{LEVELS[3]}'
      WHEN 2
      THEN '#{LEVELS[3]}'
      WHEN 3
      THEN '#{LEVELS[3]}'
      END
    SQL
    Arel.sql(field_transformation)
  end

  ransacker :subject_id do
    Arel.sql('cast(subject_id as char)')
  end

  validates :organization_id,
            numericality: { only_integer: true, allow_blank: true }
  validates :role_id, numericality: { only_integer: true }
  validates :subject_type, inclusion: { in: SUBJECT_TYPES.keys }
  validates :subject_id,
            numericality: { only_integer: true, allow_blank: true }
  validates :level, inclusion: { in: LEVELS.keys }

  # TODO: RSpec it
  validates :subject_id,
            uniqueness: { scope: [:role_id, :subject_type, :level] },
            allow_blank: true
  validates :subject_type,
            uniqueness: { scope: [:role_id, :subject_id, :level] },
            allow_blank: true,
            if: proc { |record| record.subject_id.present? }
  validates :level,
            uniqueness: { scope: [:role_id, :subject_type, :subject_id] },
            unless: proc { |r| r.subject_id.blank? }

  # Organization here is liake a security domain (scope)
  # (organization has many right_scopes)
  belongs_to :organization, optional: true

  # Role is an access subject
  belongs_to :role
  # Subject is an access subject
  belongs_to :subject, polymorphic: true, optional: true

  def self.subject_types
    SUBJECT_TYPES
  end

  def self.levels
    LEVELS
  end

  def self.action_to_level(action)
    ACTIONS[action]
  end

  def show_subject_type
    SUBJECT_TYPES[subject_type]
  end

  def show_level
    LEVELS[level]
  end
end
