# frozen_string_literal: true

module Subscriptions
  class ActivateTrial
    attr_reader :user

    TRIAL_TYPE = Rails.application.credentials.subscriptions.trial_type.to_sym

    def self.call(user)
      new(user).call
    end

    def initialize(user)
      @user = user
    end

    def call
      Purchase.call(user, TRIAL_TYPE)
    end
  end
end
