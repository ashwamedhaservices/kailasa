module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from StandardError, with: :standard_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from JWT::ExpiredSignature, with: :forbidden
    rescue_from JWT::DecodeError, with: :forbidden
    # rescue_from CanCan::AccessDenied, with: :unauthorized_request
  end

  private

  def record_not_found
    render json: { status: 'failure', data: 'invalid record' }, status: :not_found
  end

  def standard_error(_exception)
    # Kailasa::Logger.error(exception.message, sentry: true)
    render json: { status: 'failure', data: 'something went wrong' }, status: :internal_server_error
  end

  def forbidden
    render json: { status: 'failure', data: 'invalid request' }, status: :forbidden
  end

  def unauthorized_request
    render json: { status: 'failure', data: 'unauthorized' }, status: :unauthorized
  end
end
