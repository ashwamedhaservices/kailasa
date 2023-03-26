module Users
  module Create
    class Processor
      include Interactor::Organizer

      organize ValidateParams, CreateUser, SendOtp
    end
  end
end