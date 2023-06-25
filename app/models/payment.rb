# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id                 :bigint           not null, primary key
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

  enum :status, %i[created pending completed rejected refunded]
  enum :mode, %i[card upi net_banking]
  enum :platform, %i[web android ios]
  enum :for, %i[one_year_subscription]
end
