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
#  err                :string(255)
#  errdesc            :string(255)
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
# Indexes
#
#  index_payments_on_payment_gateway_id  (payment_gateway_id)
#  index_payments_on_subscription_id     (subscription_id)
#  index_payments_on_user_id             (user_id)
#
class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :subscription
  belongs_to :payment_gateway

  enum :status, %i[created initiated pending success failed refunded cancelled]
  enum :mode, %i[card upi net_banking emi bnpl cash ivrs]
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

  PAYU_MODE = {
    CC: :card,
    DC: :card,
    NB: :net_banking,
    CASH: :upi,
    EMI: :emi,
    CLEMI: :emi,
    BNPL: :bnpl
  }.freeze

  HDFC_PG_MODE_STATUS_API = {
    'OPTCASHC' => :cash,
    'OPTCRDC' => :card,
    'OPTDBCRD' => :card,
    'OPTEMI' => :emi,
    'OPTIVRS' => :ivrs,
    'OPTMOBP' => :upi,
    'OPTNBK' => :net_banking
  }.freeze

  HDFC_PG_STATUS_FOR_STATUS_API = {
    'Cancelled' => :cancelled,
    'Invalid' => :failed,
    'Fraud' => :failed,
    'Initiated' => :pending,
    'Refunded' => :refunded,
    'Shipped' => :success,
    'Systemrefund' => :refunded,
    'Unsuccessful' => :failed,
    'Timeout' => :failed
  }.freeze

  HDFC_PG_MODE = {
    'Credit Card' => :cash
  }.freeze

  HDFC_PG_STATUS = {
    'Success' => :success,
    'Failure' => :failed,
    'Aborted' => :cancelled,
    'Invalid' => :failed,
    'Timeout' => :failed
  }.freeze

  def finalized?
    %w[success failed refunded cancelled].include?(status)
  end

  def self.payu_status(status)
    PAYU_STATUS[status.to_sym]
  end

  def self.payu_payment_mode(status)
    PAYU_MODE[status.to_sym]
  end

  def self.mode_from_hdfc_api(mode)
    HDFC_PG_MODE_STATUS_API[mode]
  end

  def self.status_from_hdfc_api(status)
    HDFC_PG_STATUS_FOR_STATUS_API[status]
  end

  def self.mode_from_hdfc_response(mode)
    HDFC_PG_MODE[mode]
  end

  def self.status_from_hdfc_response(status)
    HDFC_PG_STATUS[status]
  end
end
