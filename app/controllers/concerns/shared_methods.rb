# frozen_string_literal: true

# methods that used both in Organizatiable and DefaultAactions
module SharedMethods
  extend ActiveSupport::Concern

  included do
    before_action :set_edit_previous_page, only: %i[index show]
    before_action :set_show_previous_page, only: %i[index]
  end

  private

  def record_params
    params.require(model.name.underscore.to_sym)
          .permit(policy(model).permitted_attributes)
  end

  # show record previous version instead real record if param
  # version_id is set
  def record
    if params[:version_id].present?
      PaperTrail::Version.find(params[:version_id]).reify
    else
      model.find(params[:id])
    end
  end

  # set Pundit scope, ransack query object and return query result
  def records(scope)
    scope = policy_scope(scope)
    @q = scope.ransack(params[:q])
    @q.sorts = default_sort if @q.sorts.empty?
    @q.result
      .group(group_field)
      .includes(records_includes)
      .page(params[:page])
  end

  def set_show_previous_page
    # excludes for tabbed view
    return if params[:organization_id].present?
    return if params[:user_id].present?
    return if params[:role_id].present?

    session[:show_return_to] = request.original_url
    session[:show_return_to_model] = model.model_name.human count: 2
  end

  def set_edit_previous_page
    session[:edit_return_to] = request.original_url
    count = params[:id].present? ? 1 : 2
    session[:edit_return_to_model] = model.model_name.human count: count
  end

  # set sort field and direction by default
  # (applies when go to index page from other place)
  # it uses ransack, so if you wont to set default sort by
  # associated table field, set it as associated_table_name,
  # (not associated_table.name)
  def default_sort
    'name asc'
  end

  # create new record from template
  def template_attributes
    return if params[:template_id].blank?
    RecordTemplate.find(params[:template_id]).record_content
  end

  def add_tags_from_template
    return if params[:template_id].blank?
    RecordTemplate.find(params[:template_id])
                  .tags.pluck(:id).each do |tag_id|
                    TagMember.create(
                      tag_id: tag_id,
                      record_id: @record.id,
                      record_type: @record.class.name
                    )
                  end
  end

  def group_field
    "#{model.table_name}.id"
  end
end
