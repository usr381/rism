# frozen_string_literal: true

class SearchFiltersController < ApplicationController
  include RecordOfOrganization

  def create
    @record = model.new(
      record_params.merge(
        content: JSON.parse(params[:search_filter][:content].gsub('=>', ':'))
      )
    )
    authorize @record.class
    @organization = organization
    @record.current_user = current_user
    @record.save
    add_from_template
    redirect_to(
      session.delete(:edit_return_to),
      organization_id: @organization.id,
      success: t('flashes.create', model: model.model_name.human)
    )
  end

  private

  def model
    SearchFilter
  end

  def records_includes
    %i[organization user]
  end

  def default_sort
    'rank desc'
  end
end
