# frozen_string_literal: true

module Reports
  class Info
    extend Callable
    include Service

    def call
      report
    end

    private

    def report
      {
        total_user_count: User.count,
        total_subscribed_user_count: User.subscribed.count,
        total_kyc_started: Kyc.count,
        pincode_wise_count: Address.group(:postal_code).count
      }
    end
  end
end
