# frozen_string_literal: true

module Users
  module Create
    class CreateUser
      include Interactor
      delegate :params, to: :context

      def call
        error = create_user_and_profile
        if error
          context.fail!(
            error: user.errors.full_messages.to_sentence,
            ode: ::Errors::Handler.code("#{error.first.attribute}_#{error.first.type}")
          )
        end
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

      def create_attributes
        {
          fname: full_name_array.first,
          mname: full_name_array.slice(1, full_name_array.length - 2).join(' '),
          lname: full_name_array.last,
          mobile_number: params[:mobile_number],
          password_digest: params[:password],
          referrer_id: referred_by
        }
      end

      def full_name_array
        @full_name_array ||= params[:full_name].split
      end

      def referred_by
        # sentry
        return nil unless params[:referral_code]

        user_id = params[:referral_code].downcase.to_i(36)
        ::User.exists?(user_id) ? user_id : nil
      end
    end
  end
end
