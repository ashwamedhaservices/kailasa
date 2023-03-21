module Users
  module Create
    class CreateUser
      include Interactor
      delegate :params, to: :context
      
      def call
        user = ::User.new(mobile_number: params[:mobile_number])
        if user.save
          context.user = user
        else
          context.fail!(error: user.errors.full_messages.to_sentence)
        end
      end

    end
  end
end
