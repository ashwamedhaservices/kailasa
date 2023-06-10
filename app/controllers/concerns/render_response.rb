# frozen_string_literal: true

module RenderResponse
  extend ActiveSupport::Concern
  included do
    alias_method :success, :render_success
    alias_method :failure, :render_failure
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
      error_code:,
      data:
    }
  end

  def errors_code(error)
    ::Errors::Handler.code(error)
  end
end
