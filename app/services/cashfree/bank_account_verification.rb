# frozen_string_literal: true

module Cashfree
  class BankAccountVerification < Base
    attr_reader :user, :bank

    def initialize(user, bank)
      @user = user
      @bank = bank
      super()
    end

    def call
      response = BankVerificationSync.call(user, bank, token)
      return response if response.success?

      if response.code.eql?(403)
        REDIS.del(CASHFREE_TOKEN_KEY)
        response = BankVerificationSync.call(user, bank, token)
        return response if response.success?

        raise StandardError, 'bank verification api call for cashfree failed'
      end
      raise StandardError, 'bank verification api call for cashfree failed'
    end

    private

    def token
      generate_cashfree_token
    end

    def generate_cashfree_token
      token_from_redis = REDIS.get(CASHFREE_TOKEN_KEY)
      return token_from_redis if token_from_redis

      response = Authorize.call
      if response.success?
        REDIS.setex(CASHFREE_TOKEN_KEY, (response['expiry'] - Time.now.to_i), response['token'])
        return response['token']
      end
      raise StandardError, 'authorization api call for cashfree failed'
    end
  end
end
