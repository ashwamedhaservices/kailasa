# frozen_string_literal: true

module Users
  module CallBackable
    extend ActiveSupport::Concern

    included do
      before_create :salt_password
    end

    private

    def salt_password
      self.password_digest = ::Utils::Password.encrypt(password: password_digest,
                                                       salt: Rails.application.credentials.app.password_salt)
    end
  end
end
