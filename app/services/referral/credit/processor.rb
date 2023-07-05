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

      def call # rubocop:disable Metrics/*
        configs[:depth].times do |level|
          referrer = referee.referrer
          break if referrer.nil?

          ReferralCredit.find_or_create_by(user_id: referrer.id, subscribed_user_id: user.id).tap do |credit|
            credit[:amount] = configs[:bv_value] * configs[:level_payout][level]
            credit[:level] = level
            credit[:type] = ReferralCredit::ReferralType::PARTNER
            credit.save!
          end
          @referee = referrer
        end
        ReferralCredit.create credits
      end

      def build_credit(referrer, level) # rubocop:disable Metrics/AbcSize
        {}.tap do |credit|
          credit[:amount] = configs[:bv_value] * configs[:level_payout][level]
          credit[:user_id] = referrer.id
          credit[:level] = level
          credit[:type] = ReferralCredit::ReferralType::PARTNER
          credit[:date] = DateTime.current
          credit[:subscribed_user_id] = user.id
          credit[:status] = ReferralCredit::Status::CREDITED
        end
      end

      def configs
        @configs ||= Rails.configuration.payouts
      end
    end
  end
end
