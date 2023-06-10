# frozen_string_literal: true

module Users
  module Verify
    class VerifyUser
      include Interactor
      delegate :user, to: :context
      def call
        return if user.mark_verified!

        # unless response.success?
        context.fail!(
          error: user.errors.full_messages.to_sentence,
          code: ::Errors::Handler.code('user_verification_failed')
        )
      end
    end
  end
end
