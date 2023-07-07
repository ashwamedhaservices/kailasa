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

    belongs_to :users
end
