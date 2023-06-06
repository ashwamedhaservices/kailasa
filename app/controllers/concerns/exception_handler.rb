# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from StandardError, with: :standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, with: :unauthorized_request
    rescue_from JWT::DecodeError, with: :unauthorized_request
    # rescue_from ActionController::ParameterMissing, with: :parameter_missing
    # ActionController::ParameterMissing
    # rescue_from CanCan::AccessDenied, with: :unauthorized_request
  end

  private

  def parameter_missing
    i18n_msg = 'Required parameter missing'
    code = errors_code('required_params_missing')
    render json: failure(msg: i18n_msg, error_code: code), status: :forbidden
  end

  def record_not_found
    i18n_msg = 'Record does not exists'
    code = errors_code('record_not_found')
    render json: failure(msg: i18n_msg, error_code: code), status: :not_found
  end

  def standard_error(_exception)
    i18n_msg = 'something went wrong'
    code = errors_code('standard_error')
    render json: failure(msg: i18n_msg, error_code: code), status: :internal_server_error
  end

  def forbidden
    i18n_msg = 'something went wrong'
    code = errors_code('invalid_request')
    render json: failure(msg: i18n_msg, error_code: code), status: :forbidden
  end

  def unauthorized_request
    i18n_msg = 'unauthorized'
    code = errors_code('unauthorized')
    render json: failure(msg: i18n_msg, error_code: code), status: :unauthorized
  end
end
