class Indicator < ApplicationRecord
  include OrganizationAssociated
  include Linkable
  include Tagable
  include Attachable
  include Indicator::Ransackers
  include Indicator::Formats

  attr_accessor :indicators_list
  attr_accessor :skip_format_validation
  attr_accessor :indicator_context_ids

  enum purpose: {
    not_set: 'not_set',
    for_detect: 'for_detect',
    for_prevent: 'for_prevent'
  }, _prefix: true

  enum trust_level: {
    not_set: 'not_set',
    low: 'low',
    high: 'high'
    }, _prefix: true

  formats = CONTENT_FORMATS.each_with_object({}) do |f, memo|
    memo[f[:format]] = f[:format].to_s
  end

  enum(content_format: formats)

  before_save :downcase_hashes
  after_save :set_indicator_context_member

  validate :check_content_format, unless: :skip_format_validation

  validates :investigation_id, numericality: { only_integer: true }
  validates :user_id, numericality: { only_integer: true }
  validates :trust_level, inclusion: { in: Indicator.trust_levels.values}
  validates :content_format, inclusion: { in: Indicator.content_formats.values}
  validates :content, presence: true
  validates :purpose, inclusion: { in: Indicator.purposes.values}
  validates :content, uniqueness: { scope: :investigation_id }

  belongs_to :investigation
  belongs_to :user
  has_one :organization, through: :investigation

  has_many :indicator_context_members, dependent: :delete_all
  has_many :indicator_contexts, through: :indicator_context_members

  def self.human_attribute_content_formats
    new_hash = Indicator.content_formats.map do |k,v|
      [v, Indicator.human_enum_name(:content_format, k)]
    end
    Hash[new_hash]
  end

  def self.human_attribute_trust_levels
    Hash[Indicator.trust_levels.map { |k,v| [v, Indicator.human_enum_name(:trust_level, k)] }]
  end

  def self.cast_indicator(string)
    result = CONTENT_FORMATS.each do |i|
      break {indicator_context_ids: $~[:contexts], content: $~[:content], content_format: i[:format]} if i[:pattern] =~ string
    end
    if result.is_a? Hash
      return result
    else
      return {}
    end
  end

  # TODO: translate error message
  def check_content_format
    content_format_description = CONTENT_FORMATS.find do |i|
      i[:format] == content_format.to_sym
    end
    content_with_prefix= if content_format_description.fetch(:check_prefix, false)
      "#{content_format}:#{content}"
    else
      content
    end
    casted_indicator = Indicator.cast_indicator(content_with_prefix)
    return if casted_indicator[:content_format] == content_format.to_sym
    errors.add(:content, :wrong_format_or_dublication)
  end

  def downcase_hashes
    return unless [:md5, :sha512, :sha256].include?(content_format.to_sym)
    self.content = self.content.downcase
  end

  def set_indicator_context_member
    return if indicator_context_ids.blank?
    SetIndicatorContextsService.call(id, indicator_context_ids)
  end
end