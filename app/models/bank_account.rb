# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_accounts
#
#  id             :bigint           not null, primary key
#  account_number :string(255)
#  status         :integer          default("created")
#  account_type   :integer          default("savings")
#  ifsc           :string(255)
#  micr           :string(255)
#  bank           :string(255)
#  branch         :string(255)
#  city           :string(255)
#  proof_type     :integer          default("not_submitted")
#  proof_url      :string(255)
#  kyc_id         :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_bank_accounts_on_account_number  (account_number)
#  index_bank_accounts_on_kyc_id          (kyc_id)
#
class BankAccount < ApplicationRecord
  belongs_to :kyc

  enum status: { created: 0, verified: 1 }
  enum account_type: { savings: 0, current: 1 }
  enum proof_type: { not_submitted: 0, cancelled_cheque: 1 }
end
