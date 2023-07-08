# frozen_string_literal: true

module Cashfree
  class BankVerificationSync < Base
    attr_reader :user, :bank, :token

    def initialize(user, bank, token)
      @user = user
      @bank = bank
      @token = token
      super()
    end

    def call
      response = RestRequestHandler.new(base_api).get("#{bank_url}?#{payload}", headers)
      if response[:code].eql?(200) && response.dig(:body, 'status').eql?('SUCCESS')
        return success(data: response.dig(:body, 'data'))
      end

      error(msg: response.dig(:body, 'message'), code: response.dig(:body, 'subCode'), data: response)
    end

    private

    def payload
      {
        name: user.full_name,
        bankAccount: bank.account_number,
        ifsc: bank.ifsc,
        phone: user.mobile_number,
        remarks: 'Ashwamedha bank verification'
      }.compact.to_query
    end

    def headers
      {
        authorization: "Bearer #{token}",
        accept: 'application/json'
      }
    end
  end
end
