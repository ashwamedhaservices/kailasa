# frozen_string_literal: true

module Users
  module Create
    class CreateUser
      include Interactor
      delegate :params, to: :context

      def call
        user = context.user = create_user_and_profile
        context_fail(user) unless user.errors.empty?
        referral_code_assign(user)
        credit_referral_reward(user)
        context.profile = user.profiles.first
      end

      private

      def context_fail(user)
        context.fail!(
          error: user.errors.full_messages.to_sentence,
          code: ::Errors::Handler.code("#{user.errors.first.attribute}_#{user.errors.first.type}")
        )
      end

      def create_user_and_profile # rubocop:disable Metrics
        ::User.new.tap do |user|
          user.fname = full_name_array.first.camelize
          user.mname =  (full_name_array.slice(1, full_name_array.length - 2) || []).join(' ').camelize
          user.lname =  full_name_array.last.camelize
          user.mobile_number = params[:mobile_number]
          user.password_digest = params[:password]
          user.type = 'student'
          user.referrer_id = referred_by
          user.profiles = [user.profiles.build(name: 'Default')]

          user.save
        end
      end

      def full_name_array
        @full_name_array ||= params[:full_name].split
      end

      def referred_by
        return unless params[:referral_code]

        if params[:referral_code].size == 10
          User.find_by(mobile_number: params[:referral_code])
        else
          User.find_by(referral_code: params[:referral_code])
        end
      end

      def referral_code_assign(user)
        user.update(referral_code: user.id.to_s.upcase.rjust(7, '0'))
      end

      def credit_referral_reward(user)
        ::Referral::Credit::Processor.call(user) if user.referrer_id
      end
    end
  end
end
