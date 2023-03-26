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
      self.passwd = ::Utils::Password.encrypt(password: passwd, salt: salt)
    end
  end
end
