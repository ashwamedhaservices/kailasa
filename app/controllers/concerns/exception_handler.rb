module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from StandardError, with: :standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, with: :forbidden
    rescue_from JWT::DecodeError, with: :forbidden
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    # ActionController::ParameterMissing
    # rescue_from CanCan::AccessDenied, with: :unauthorized_request
  end

  private

  def parameter_missing
    render json: failure(msg: 'Required parameter missing', error_code: error_code('required_params_missing')), status: :forbidden
  end

  def record_not_found
    render json: failure(msg: 'Record does not exists', error_code: error_code('record_not_found')), status: :not_found
  end

  def standard_error(_exception)
    render json: { status: 'failure', data: 'something went wrong' }, status: :internal_server_error
  end

  def forbidden
    render json: { status: 'failure', data: 'invalid request' }, status: :forbidden
  end

  def unauthorized_request
    render json: { status: 'failure', data: 'unauthorized' }, status: :unauthorized
  end
end
