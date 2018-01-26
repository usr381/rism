# frozen_string_literal: true

class RoleMembersController < ApplicationController
  include Record

  def index
    authorize model
    user_id = if params[:user_id]
                params[:user_id]
              else
                params[:q][:user_id_eq]
              end
    @user = User.find(user_id)
    scope = model.where(user_id: @user.id)
    @records = records(scope)
  end

  def new
    authorize model
    @record = model.new
    @user = User.find(params[:user_id])
    @roles = Role.all
  end

  def create
    authorize model
    @roles = Role.all
    @record = model.new(record_params)
    @user = User.find(params[:role_member][:user_id])
    @record.save!
    redirect_to(
      role_members_path(user_id: @user.id),
      success: t('flashes.create', model: model.model_name.human)
    )
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def destroy
    @record = model.find(params[:id])
    authorize @record
    @record.destroy
    redirect_to(
      polymorphic_url(@record.class, user_id: @record.user.id),
      success: t('flashes.destroy', model: model.model_name.human)
    )
  end

  private

  def model
    RoleMember
  end

  def default_includes
    [:role]
  end
end
