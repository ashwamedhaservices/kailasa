# frozen_string_literal: true

module Payments
  class PaymentSuccess
    include Service

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def subscribe
      user.subscribed!
      Subscriptions::Purchase.call(user, :one_year)
      Referral::Credit::Processor.call(user)
    end
  end
end
