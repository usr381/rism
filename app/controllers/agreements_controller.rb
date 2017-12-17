class AgreementsController < ApplicationController
  include DefaultMethods
  include Organizatable

  before_action :set_attachment, only: [:show]

  private
  def get_model
    Agreement
  end

  def set_attachment
    @attahment = Attachment.new
  end
end