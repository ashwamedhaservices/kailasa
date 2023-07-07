# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_accounts
#
#  id             :bigint           not null, primary key
#  account_number :string(255)
#  status         :integer          default(0)
#  type           :integer          default(0)
#  ifsc           :string(255)
#  micr           :string(255)
#  proof_type     :integer          default(0)
#  proof_url      :string(255)
#  users_id       :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_bank_accounts_on_account_number  (account_number)
#  index_bank_accounts_on_users_id        (users_id)
#
class BankAccount < ApplicationRecord
end
