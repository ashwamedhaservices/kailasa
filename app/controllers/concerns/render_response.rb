module RenderResponse
  extend ActiveSupport::Concern
  included do
    alias_method :success, :render_success
    alias_method :failure, :render_failure
  end

  def render_success(msg: '', data: {})
    {}.tap do |resp|
      resp[:success] = true
      resp[:message] = msg
      resp[:data] = data[:data] || data
    end
  end

  def render_failure(msg: '', error_code: '', data: {})
    {
      success: false,
      message: msg,
      error_code: error_code,
      data: data
    }
  end

  def error_code(error)
    ::Errors::Handler.code(error)
  end
end
