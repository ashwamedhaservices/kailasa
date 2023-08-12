# frozen_string_literal: true

module Cashfree
  class BankAccountVerificationJob
    include Sidekiq::Job

    def perform(user, bank_account); end
  end
end
