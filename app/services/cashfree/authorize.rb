# frozen_string_literal: true

module Cashfree
  class Authorize < Base
    def call
      response = RestRequestHandler.new(base_api).post(authorize_url, nil, headers)
      return error(msg: 'cashfree authorize api call failed', data: response[:body]) unless response[:code].eql?(200)
      if response.dig(:body, 'status').eql?('ERROR')
        return error(msg: response.dig(:body, 'message'), code: response.dig(:body, 'subCode'))
      end

      success(data: response.dig(:body, 'data'))
    end

    private

    def payload
      {
        'X-Cf-Signature': generate_signature
      }
    end

    def headers
      {
        'X-Client-Id': client_id,
        'X-Client-Secret': client_secret,
        accept: 'application/json',
        'X-Cf-Signature': generate_signature
      }.compact
    end

    def generate_signature
      return nil if ip_whitelisted

      public_key = OpenSSL::PKey::RSA.new(File.read(public_key_path))
      timestamp = DateTime.now.to_i
      data = "#{client_id}.#{timestamp}"
      Base64.strict_encode64(public_key.public_encrypt(data, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)).encode('UTF-8')
    end
  end
end
