# frozen_string_literal: true

module Payments
  module Payu
    class ParseReturnUrl
      extend Callable
      include Service

      attr_reader :params

      def initialize(params)
        @params = params
      end

      def call
        Payu::Success.call(payment, params[:unmappedstatus], success_options) if params[:status] == 'success'
        Payu::Failure.call(payment, params[:unmappedstatus])
      end

      private

      def payment
        @payment ||= Payment.find_by(uuid: params[:txnid])
      end

      def success_options
        { mode: params[:mode], pg_transaction_no: params[:bank_ref_num], txn_reference_no: params[:mihpayid],
          settlement_time: params[:addedon], notes: params[:bankcode] }
      end
    end
  end
end
