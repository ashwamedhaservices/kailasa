# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthorizationHandler
  include ActionController::MimeResponds
  include RenderResponse
  # TODO: might backfire.. To think about it
  delegate :success?, :error, :code, to: :interactor
  attr_accessor :interactor, :current_user, :current_profile
end
