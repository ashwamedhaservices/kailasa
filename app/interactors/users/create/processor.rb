# frozen_string_literal: true

module Users
  module Create
    class Processor
      include Interactor::Organizer

      organize ValidateParams, CreateUser, SendOtp, CreateSubscription
    end
  end
end
