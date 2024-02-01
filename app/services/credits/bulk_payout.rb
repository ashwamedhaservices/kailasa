module Credits
  class BulkPayout
    extend Callable
    include Service

    attr_reader :payouts

    def initialize(payouts)
      @payouts = payouts
    end

    def call
      credits = []
      payouts.each do |payout|
        credits << { user_id: payout['user_id'],
                     amount: payout['amount'],
                     status: 'paid',
                     credit_type: payout['credit_type'],
                     date: DateTime.current }
      end
      res = Credit.insert_all!(credits) # rubocop:disable Rails/SkipsModelValidations
      Rails.logger.info("bulk update result is #{res} for payouts #{payouts}")
    end
  end
end
