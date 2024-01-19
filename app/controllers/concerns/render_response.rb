# frozen_string_literal: true

module RenderResponse
  extend ActiveSupport::Concern
  included do
    alias_method :success, :render_success
    alias_method :failure, :render_failure
  end

  def json_success(msg: '', data: {})
    render json: render_success(msg:, data:), status: :ok
  end

  def json_created(msg: '', data: {})
    render json: render_success(msg:, data:), status: :created
  end

  def json_failure(msg: '', error_code: '', data: {})
    render json: render_failure(msg:, error_code:, data:), status: :bad_request
  end

  def json_unauthorised(msg: '', data: {})
    render json: render_failure(msg:, error_code: :unauthorised, data:), status: :unauthorised
  end

  def render_success(msg: '', data: {})
    {
      success: true,
      message: msg,
      data:
    }
  end

  def render_failure(msg: '', error_code: '', data: {})
    {
      success: false,
      message: msg,
      error_code: errors_code(error_code),
      data:
    }
  end

  def errors_code(error = nil)
    ::Errors::Handler.code(error)
  end
end
