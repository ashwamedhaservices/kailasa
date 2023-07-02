# frozen_string_literal: true

module Payments
  module Payu
    class PaymentReportJob
      include Sidekiq::Job

      def perform
        report = [%w[id status txn_reference_no settlement_time]]
        todays_payments.find_each do |payment|
          report << [payment.id, payment.status, payment.txn_reference_no, payment.settlement_time]
        end
        file = Tempfile.new(file_name)
        wirte_report_to_temp_file(file, report)
        s3_client.upload_file('kailasa-bucket1', file, "reports/payments/#{file_name}")
      end

      private

      def todays_payments
        Payment.where(settlement_time: DateTime.current.beginning_of_day...DateTime.current)
      end

      def wirte_report_to_temp_file(file, report)
        csv_string = ''
        report.each do |row|
          csv_string << row.join(',') << "\n"
        end
        file.write_nonblock(csv_string)
      end

      def file_name
        "payment_report_#{Date.current}.csv"
      end

      def s3_client
        Cloud::S3Client.new(Cloud::Credentials.s3)
      end
    end
  end
end
