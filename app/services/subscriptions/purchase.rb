# frozen_string_literal: true

module Subscriptions
  class Purchase
    attr_reader :user, :kind

    def self.call(user, kind)
      new(user, kind).call
    end

    def initialize(user, kind)
      @user = user
      @kind = kind
    end

    def call
      kind.eql?(:unsubscribed) ? unsubscribe : subscribe
      Rails.logger.info("Purchase Subscription #{kind} for user #{user.id}, subscription #{subscription}")
      return ServiceResponse.success(data: subscription) if subscription.save

      ServiceResponse.error(msg: 'unable to perform subscription action', data: subscription)
    end

    private

    def subscribe
      subscription.status = :active
      subscription.kind = kind
      subscription.start_date = start_date
      subscription.end_date = end_date
    end

    def unsubscribe
      subscription.status = :inactive
      subscription.kind = nil
      subscription.start_date = nil
      subscription.end_date = nil
    end

    def subscription
      @subscription ||= user.subscription || user.build_subscription
    end

    def start_date
      @start_date ||= DateTime.current.beginning_of_day
    end

    def end_date
      DateTime.current.beginning_of_day + Subscription.period(kind)
    end
  end
end
