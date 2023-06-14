# frozen_string_literal: true

module Referral
  module Credit
    class Processor
      attr_reader :user, :referee

      def initialize(user)
        @referee = @user = user
      end

      def self.call(user)
        new(user).call
      end

      def call
        credits = []
        configs[:depth].times do |level|
          referrer = referee.referrer
          break if referrer.nil?

          credits << build_credit(referrer, level + 1)
          @referee = referrer
        end
        ReferralCredit.create credits
      end

      def build_credit(referrer, level)
        {}.tap do |credit|
          credit[:amount] = configs[:bv_value] * configs[:level_payout][level]
          credit[:user_id] = referrer.id
          credit[:level] = level
          credit[:type] = ReferralCredit::ReferralType::PARTNER
          credit[:subscribed_user_id] = user.id
        end
      end

      def configs
        @configs ||= Rails.configuration.payouts
      end
    end
  end
end
