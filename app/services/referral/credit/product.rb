# frozen_string_literal: true

module Referral
  module Credit
    class Product
      extend Callable
      include Service

      attr_reader :user, :referred_user, :product, :product_details

      def initialize(user, referred_user, product)
        @user = user
        @referred_user = referred_user
        @product = product
        @product_details = Rails.configuration.product_details[product]
      end

      def call
        return error(msg: 'product not found') unless product_details
        return error(msg: 'user referral limit reached') if user_referral_limit_reached?

        ActiveRecord::Base.transaction { process_subscription }
      rescue StandardError => e
        Rails.logger.error("subscribe failed user_id #{user.id}, #{referred_user.id}, product: #{product} error: #{e}")
        error(msg: 'unable to subscribe the user', data: e)
      end

      private

      def users_product_subscription
        @users_product_subscription ||= user.product_subscriptions.where(category: product)
      end

      def user_referral_limit_reached?
        users_product_subscription.referral_count >= product_details.dig(:referral_limit,
                                                                         users_product_subscription.user_category)
      end

      def process_subscription
        unless referred_user.subscribed?
          referred_user.subscribed!
          Subscriptions::Purchase.call(referred_user, :one_year)
        end
        create_product_subscriptions_for_referred_user!
        update_users_referral!
        success(msg: 'referred user subscribed to the product')
      end

      def create_product_subscriptions_for_referred_user!
        @referred_user_product_subscription = referred_user.product_subscriptions.create!(
          category: product,
          user_category: 'user',
          status: 'subscribed',
          name: users_product_subscription.name,
          amount: product_details[:amount],
          referral_count: 0
        )
      end

      def update_users_referral!
        user.product_referrals.create(referred_user_id: referred_user.id,
                                      product_subscription_id: @referred_user_product_subscription.id)
        users_product_subscription.update!(referral_count: users_product_subscription.referral_count + 1)
      end
    end
  end
end
