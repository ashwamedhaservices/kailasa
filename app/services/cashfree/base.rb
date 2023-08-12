# frozen_string_literal: true

module Cashfree
  class Base
    extend Callable
    include Service

    CASHFREE_TOKEN_KEY = 'cashfree_token'

    delegate :public_key_path, :client_id, :client_secret, :verification_api, :ip_whitelisted, to: :credentails
    delegate :base_api, :authorize_url, :bank_url, to: :verification_api

    def credentails
      @credentails ||= Rails.application.credentials.cashfree
    end
  end
end
