# frozen_string_literal: true

class ServiceResponse
  class << self
    def success(msg: '', data: {})
      OpenStruct.new({
                       success: true,
                       message: msg,
                       data: data
                     })
    end

    def error(msg: '', error_code: '', data: {})
      OpenStruct.new({
                       success: false,
                       message: msg,
                       error_code: error_code,
                       data: data
                     })
    end
  end
end
