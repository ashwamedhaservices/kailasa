# frozen_string_literal: true

module Payments
  class ParseReturnUrl
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def self.call(params)
      new(params).call
    end

    def call
      Payu::Success.call(payment, params[:unmappedstatus]) if params[:status] == 'success'
      Payu::Failure.call(payment, params[:unmappedstatus])
    end

    private

    def payment
      @payment ||= Payment.find_by(uuid: params[:txnid])
    end

    def success_options
      { mode: params[:mode], pg_transaction_no: params[:bank_ref_num], txn_reference_no: params[:mihpayid],
        settlement_time: params[:addedon] }
    end
  end
end