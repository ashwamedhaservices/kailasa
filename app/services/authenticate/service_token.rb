module Authenticate
  class ServiceToken
    REGISTERED_SERVICES = Rails.application.credentials.registered_services
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      authenticate_service
    end

    private

    def authenticate_service
      if auth_token.nil?
        # Kailasa::Logger.error('No Service Authorization header present in the request')
        return ServiceResponse.error(message: 'Authentication failed', http_status: 401)
      end

      unless registered?
        # Kailasa::Logger.error('Service token is not whitelisted')
        return ServiceResponse.error(message: 'Authentication failed', http_status: 401)
      end

      ServiceResponse.success(payload: { 'auth': true })
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
      Kailasa::Jwt.decode(http_token)
    end
  end
end
