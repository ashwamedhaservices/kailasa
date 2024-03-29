# frozen_string_literal: true

module Authenticate
  class ServiceToken
    extend Callable
    include Service

    attr_reader :request

    REGISTERED_SERVICES = Rails.application.credentials.registered_services

    def initialize(request)
      @request = request
    end

    def call
      authenticate_service
    end

    private

    def authenticate_service
      if auth_token.nil?
        # Kailasa::Logger.error('No Service Authorization header present in the request')
        return error(msg: 'Authentication failed')
      end

      unless registered?
        # Kailasa::Logger.error('Service token is not whitelisted')
        return error(msg: 'Authentication failed')
      end

      success(data: { auth: true })
    end

    def registered?
      return false if auth_token.blank?

      REGISTERED_SERVICES.include?(auth_token['service_id'])
    end

    def http_token
      @http_token ||= if request.headers['ServiceAuthorization'].present?
                        request.headers['ServiceAuthorization'].split.last
                      end
    end

    def auth_token
      @auth_token ||= decoded_payload
    end

    def decoded_payload
      ::Kailasa::Jwt.decode(http_token)
    end
  end
end
