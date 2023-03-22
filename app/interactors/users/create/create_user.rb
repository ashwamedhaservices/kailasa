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
          # TODO ERROR CODES
          # user.errors.first.attribute.to_s + "_" + user.errors.first.type.to_s
          context.fail!(error: user.errors.full_messages.to_sentence, code: )
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
