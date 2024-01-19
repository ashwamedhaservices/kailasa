# frozen_string_literal: true

module Referral
  module Credit
    class Processor
      extend Callable
      include Service

      attr_reader :user, :referee

      def initialize(user)
        @referee = @user = user
      end

      def call # rubocop:disable Metrics/*
        Rails.logger.info("Process credit for user #{user.id}")
        configs[:depth].times do |level|
          referrer = referee.referrer
          level += 1
          break if referrer.nil?

          Rails.logger.info("Processing credit for user #{user.id} level #{level}, referrer #{referrer.id}")
          ::Credit.partner.find_or_create_by(user_id: referrer.id, for_user_id: user.id).tap do |credit|
            credit[:amount] = configs[:bv_value] * configs[:level_payout][level]
            credit[:level] = level
            credit[:credit_type] = 'partner'
            credit[:date] = DateTime.current
            credit[:status] = 'credited'
            credit.save!
          end
          Rails.logger.info("Processed credit for user #{user.id} level #{level}, referrer #{referrer.id}")
          @referee = referrer
        end
        # ReferralCredit.create credits
      end

      def configs
        @configs ||= Rails.configuration.payouts
      end
    end
  end
end
