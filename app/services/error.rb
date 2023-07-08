# frozen_string_literal: true

Error = Struct.new(:success, :message, :code, :body) do
  def success?
    false
  end

  def msg
    message
  end

  def error_code
    code
  end

  def data
    body
  end
end
