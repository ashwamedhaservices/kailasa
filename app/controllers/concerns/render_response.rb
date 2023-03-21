module RenderResponse
  extend ActiveSupport::Concern

  def render_success(msg, data)
    {
      success: true,
      message: msg,
      data: data
    }
  end

  def render_failure(msg, error_code, data = [])
    {
      success: false,
      message: msg,
      error_code: error_code,
      data: data
    }
  end
end
