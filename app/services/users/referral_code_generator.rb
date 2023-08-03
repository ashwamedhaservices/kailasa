# frozen_string_literal: true

module Users
  class ReferralCodeGenerator
    extend Callable
    include Service

    def call
      generate_unique_code
    end

    private

    def generate_unique_code
      # Define the characters you want to include in the code
      charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
      code = Array.new(6) { charset.sample }.join # Generate a random 6-character code

      # Check if the generated code is unique
      code = Array.new(6) { charset.sample }.join while code_already_exists?(code)

      code
    end

    def code_already_exists?(code)
      User.exists?(referral_code: code)
    end
  end
end
