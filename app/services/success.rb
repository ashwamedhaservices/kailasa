# frozen_string_literal: true

Success = Struct.new(:success, :message, :body) do
  def success?
    true
  end

  def msg
    message
  end

  def code
    nil
  end

  def data
    body
  end
end
