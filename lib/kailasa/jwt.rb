module Kailasa
  class Jwt
    class << self
      SECRET = Rails.application.credentials.secret_key_base
      ALGORITHM = 'HS256'.freeze

      def encode(payload)
        JWT.encode payload, SECRET, ALGORITHM
      end

      def decode(token)
        payload = JWT.decode(token, SECRET, true, { algorithm: ALGORITHM }).first
        ActiveSupport::HashWithIndifferentAccess.new(payload)
      rescue JWT::ExpiredSignature => e
        # Logger("token signer expired: #{e.message}")
        raise e
      rescue StandardError => e
        # Logger("unable to decode the token: #{e.message}")
        nil
      end
    end
  end
end
