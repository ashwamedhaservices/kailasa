# frozen_string_literal: true

module Users
  module Create
    class CreateUser
      include Interactor
      delegate :params, to: :context

      def call # rubocop:disable Metrics/AbcSize
        error = create_user_and_profile
        if error
          context.fail!(
            error: user.errors.full_messages.to_sentence,
            code: ::Errors::Handler.code("#{error.first.attribute}_#{error.first.type}")
          )
        end
        credit_referral_reward
        context.user = user
        context.profile = profile
      end

      private

      def create_user_and_profile
        if user.save
          profile.save ? nil : profile.errors
        else
          user.errors
        end
      end

      def user
        @user ||= ::User.new(create_attributes)
      end

      def profile
        @profile ||= user.profiles.build(name: 'Default')
      end

      def create_attributes # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        {}.tap do |ca|
          ca[:fname] = full_name_array.first.camelize
          ca[:mname] =  (full_name_array.slice(1, full_name_array.length - 2) || []).join(' ').camelize
          ca[:lname] =  full_name_array.last.camelize
          ca[:mobile_number] = params[:mobile_number]
          ca[:password_digest] = params[:password]
          ca[:type] = 'student'
          ca[:referrer_id] = referred_by
          ca[:referral_code] = Users::ReferralCodeGenerator.call
          ca[:state] = :verified # TODO: remove later once otp is working
        end
      end

      def full_name_array
        @full_name_array ||= params[:full_name].split
      end

      def referred_by
        Users::Refer.call(params[:referral_code])
      end

      def credit_referral_reward
        ::Referral::Credit::Processor.call(user)
      end
    end
  end
end
