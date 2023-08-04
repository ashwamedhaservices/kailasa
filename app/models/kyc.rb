# frozen_string_literal: true

# == Schema Information
#
# Table name: kycs
#
#  id                 :bigint           not null, primary key
#  status             :integer          default(0)
#  name               :string(255)
#  id_proof_no        :string(255)
#  id_proof_url       :string(255)
#  id_proof_type      :integer
#  address_proof_no   :string(255)
#  address_proof_url  :string(255)
#  address_proof_type :integer
#  user_id            :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_kycs_on_user_id  (user_id)
#
class Kyc < ApplicationRecord
  belongs_to :user
  has_many :bank_accounts, dependent: :restrict_with_error

  enum status: { created: 0, verified: 1 }
  enum id_proof_type: { pan: 0, aadhaar: 1 }, _prefix: :id_prood
  enum address_proof_type: { aadhaar: 0, passport: 1 }, _prefix: :address_proof
end
