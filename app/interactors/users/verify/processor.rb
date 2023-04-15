# frozen_string_literal: true

module Users
  module Verify
    class Processor
      include Interactor::Organizer

      organize ValidateParams, VerifyOtp
    end
  end
end
