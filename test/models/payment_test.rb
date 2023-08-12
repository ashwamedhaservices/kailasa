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
# Indexes
#
#  index_payments_on_payment_gateway_id  (payment_gateway_id)
#  index_payments_on_subscription_id     (subscription_id)
#  index_payments_on_user_id             (user_id)
#
require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
