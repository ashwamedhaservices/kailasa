# frozen_string_literal: true

# ServiceResponse class manages the response convention followed by all the services in the project
class ServiceResponse
  class << self
    def success(message: '', data: {})
      Struct.new({ success: true, message:, data: })
    end

    def error(message: '', error_code: '', data: {})
      Struct.new({ success: false, message:, error_code:, data: })
    end
  end
end
