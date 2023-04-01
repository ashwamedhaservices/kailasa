module Authenticate
  class Users
    attr_reader :request, :token

    def initialize(request, token)
      @request = request
      @token = token
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      authenticate
    end

    private

    def authenticate
      # custom checks to go here
      return ::ServiceResponse.success(data: payload) if payload

      ::ServiceResponse.error(msg: 'Authorization failed')
    end

    def payload
      @payload ||= Kailasa::Jwt.decode(token)
    end
  end
end
