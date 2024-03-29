# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  include ExceptionHandler
  include AuthorizationHandler
  include ActionController::MimeResponds
  include RenderResponse
  include PaginationHandler

  # TODO: might backfire.. To think about it
  delegate :error, :code, to: :interactor
  delegate :msg, :error_code, :data, to: :result
  attr_accessor :interactor, :result, :current_user, :current_profile

  def success?
    return interactor.success? if interactor.present?
    return result.success? if result.present?

    false
  end
end
