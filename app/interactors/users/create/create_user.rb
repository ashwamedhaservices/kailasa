# frozen_string_literal: true

module Users
  module Create
    class CreateUser
      include Interactor
      delegate :params, to: :context

      def call
        user = ::User.new(create_attributes)
        if user.save
          context.user = user
        else
          # TODO: ERROR CODES
          error = user.errors.first
          error_name = "#{error.attribute}_#{error.type}"
          code = ::Errors::Handler.code(error_name)
          context.fail!(error: user.errors.full_messages.to_sentence, code: code)
        end
      end

      def create_attributes
        {}.tap do |options|
          options[:mobile_number] = params[:mobile_number]
          options[:password] = params[:password]
          options[:referred_by] = referred_by if params[:referral_code]
        end
      end

      def referred_by
        # sentry
        user_id = params[:referral_code].downcase.to_i(36)
        ::User.exists?(user_id) ? user_id : nil
      end
    end
  end
end
