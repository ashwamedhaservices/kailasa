module Users
  module StateMachine
    extend ActiveSupport::Concern

    included do
      include AASM

      aasm column: :state do
        state :created, initial: true, after_enter: :send_verification_otp
        state :verified, before_enter: :update_referral_code
        state :active, :inactive, :blocked
        event :mark_verified do
          transitions from: :created, to: :verified # , :if => :created?
        end
      end
    end

    private

    def update_referral_code
      # 59999999 - 59 mn users with 5 char referral code
      Rails.logger.info 'referral code update'
      referral_code = id.to_s(36).upcase.rjust(5, '0')
      save
    end

    def send_verification_otp
      # OTP to be triggered from here
      Rails.logger.info 'Sending OTP'
    end
  end
end
