# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthenticatesWithJwt
  include ActionController::MimeResponds
end
