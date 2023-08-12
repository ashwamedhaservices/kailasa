# frozen_string_literal: true

module Service
  def success(msg: '', data: {})
    Success.new(true, msg, data)
  end

  def error(msg: '', code: '', data: {})
    Error.new(false, msg, code, data)
  end
end
