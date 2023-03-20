module Authenticate
  class Users
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      authenticate
    end

    private

    def authenticate
      if auth_token.nil?
        # Kailasa::Logger.error('No Service Authorization header present in the request')
        return ServiceResponse.error(message: 'Authentication failed', http_status: 401)
      end
      ServiceResponse.success(payload: payload)
    end

    def auth_token
      @http_token ||= auth_header.split.last if auth_header
    end

    def auth_header
      @auth_header ||= request.headers['Authorization']
    end

    def payload
      @payload ||= Kailasa::Jwt.decode(http_token)
    end
  end
end
