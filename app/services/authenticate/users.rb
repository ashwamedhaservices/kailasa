# frozen_string_literal: true

module Authenticate
  class Users
    extend Callable
    include Service

    attr_reader :request, :token

    def initialize(request, token)
      @request = request
      @token = token
    end

    def call
      authenticate
    end

    private

    def authenticate
      # custom checks to go here
      return success(data: payload) if payload

      error(msg: 'Authorization failed')
    end

    def payload
      @payload ||= Kailasa::Jwt.decode(token)
    end
  end
end
