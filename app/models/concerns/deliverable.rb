# frozen_string_literal: true

module Deliverable
  extend ActiveSupport::Concern

  included do
    has_many :delivery_subjects, as: :deliverable, dependent: :delete_all
    has_many :delivery_lists, through: :delivery_subjects
  end
end
