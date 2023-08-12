# frozen_string_literal: true

module Subscriptions
  class ActivateTrial
    extend Callable
    include Service

    attr_reader :user

    TRIAL_TYPE = Rails.application.credentials.subscriptions.trial_type.to_sym

    def initialize(user)
      @user = user
    end

    def call
      Purchase.call(user, TRIAL_TYPE)
    end
  end
end
