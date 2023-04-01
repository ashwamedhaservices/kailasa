# frozen_string_literal: true

# ServiceResponse class manages the response convention followed by all the services in the project
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
