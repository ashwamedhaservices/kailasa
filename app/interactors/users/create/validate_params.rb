# frozen_string_literal: true

module Users
  module Create
    class ValidateParams
      include Interactor
      delegate :params, to: :context

      def call
        return unless params[:mobile_number]

        context.fail!(error: 'Invalid mobile number, please enter a valid number.') unless valid_mobile?
      end

      private

      def valid_mobile?
        ::Utils::Validator.valid_indian_phone_number?(params[:mobile_number])
      end
    end
  end
end
