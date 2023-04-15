module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from StandardError, with: :standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, with: :forbidden
    rescue_from JWT::DecodeError, with: :forbidden
    # rescue_from ActionController::ParameterMissing, with: :parameter_missing
    # ActionController::ParameterMissing
    # rescue_from CanCan::AccessDenied, with: :unauthorized_request
  end

  private

  def parameter_missing
    i18n_msg = 'Required parameter missing'
    code = error_code('required_params_missing')
    render json: failure(msg: i18n_msg, error_code: code), status: :forbidden
  end

  def record_not_found
    i18n_msg = 'Record does not exists'
    code = error_code('record_not_found')
    render json: failure(msg: i18n_msg, error_code: code), status: :not_found
  end

  def standard_error(_exception)
    i18n_msg = 'something went wrong'
    code = error_code('standard_error')
    render json: failure(msg: i18n_msg, error_code: code), status: :internal_server_error
  end

  def forbidden
    i18n_msg = 'something went wrong'
    code = error_code('invalid_request')
    render json: failure(msg: i18n_msg, error_code: code), status: :forbidden
  end

  def unauthorized_request
    i18n_msg = 'unauthorized'
    code = error_code('unauthorized')
    render json: failure(msg: i18n_msg, error_code: code), status: :unauthorized
  end
end
