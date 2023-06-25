# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id                 :bigint           not null, primary key
#  uuid               :string(255)
#  amount             :string(255)
#  status             :integer          default("created")
#  mode               :integer
#  platform           :integer
#  for                :integer
#  notes              :string(255)
#  pg_transaction_no  :string(255)
#  txn_reference_no   :string(255)
#  settlement_time    :datetime
#  refund_time        :datetime
#  user_id            :bigint           not null
#  subscription_id    :bigint           not null
#  payment_gateway_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Payment < ApplicationRecord
  include Payments::Associatable

  enum :status, %i[created initiated pending success failed refunded cancelled]
  enum :mode, %i[card upi net_banking]
  enum :platform, %i[web android ios]
  enum :for, %i[one_year_subscription]

  # source https://devguide.payu.in/api/miscellaneous/status-explanations/
  PAYU_STATUS = {
    auth: :pending,
    captured: :success,
    userCancelled: :cancelled,
    bounced: :failed,
    dropped: :failed,
    failed: :failed,
    autoRefund: :refunded,
    initiated: :pending,
    'in progress': :pending
  }.freeze

  def self.payu_status(status)
    PAYU_STATUS[status.to_sym]
  end
end
