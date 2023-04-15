# frozen_string_literal: true

module Users
  module CallBackable
    extend ActiveSupport::Concern

    # callbacks
    included do
      before_create :salt_password
    end

    private

    def salt_password
      self.salt   =  SecureRandom.hex(8)
      self.iters  =  1000
      self.password = ::Utils::Password.encrypt(password: password, salt: salt)
    end
  end
end
