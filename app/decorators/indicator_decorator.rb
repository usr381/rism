# frozen_string_literal: true
class IndicatorDecorator < SimpleDelegator
  def self.wrap(collection)
    collection.map do |obj|
      new obj
    end
  end

  def show_content_kind
    Indicator.human_enum_name(:content_kind, content_kind)
  end

  def show_content_subkinds
    #Indicator.human_enum_name(:content_subkind, content_kind)
    content_subkinds
  end

  def show_danger
    return I18n.t('labels.indicator.danger') if danger
    I18n.t('labels.indicator.not_danger')
  end

  def show_trust_level
    Indicator.human_enum_name(:trust_level, trust_level)
  end

  def show_investigation_full_name
    id_digest = Digest::MD5.hexdigest(investigation_id.to_s)[-4..-1]
    "#{id_digest} (#{investigation.name})"
  end

  def show_appearance
    Indicator.where(content: content).count
  end
end
