# frozen_string_literal: true

module Users
  module CallBackable
    extend ActiveSupport::Concern

    included do
      before_create :salt_password
    end

    private

    def salt_password
      self.salt = SecureRandom.hex(8)
      self.iters = 1000
      self.password_digest = ::Utils::Password.encrypt(password: password_digest, salt:, iters:)
    end
  end
end
