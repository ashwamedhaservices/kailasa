# frozen_string_literal: true

# ServiceResponse class manages the response convention followed by all the services in the project
class ServiceResponse
  class << self
    def success(msg: '', data: {})
      Success.new(true, msg, data)
    end

    def error(msg: '', code: '', data: {})
      Error.new(false, msg, code, data)
    end
    # Success = Struct.new(:success, :message, :body) do
    #   def success?
    #     true
    #   end

    #   def msg
    #     message
    #   end

    #   def code
    #     nil
    #   end

    #   def data
    #     body
    #   end
    # end

    # Error = Struct.new(:success, :message, :code, :body) do
    #   def success?
    #     false
    #   end

    #   def msg
    #     message
    #   end

    #   def error_code
    #     code
    #   end

    #   def data
    #     body
    #   end
    # end
  end
end
