# frozen_string_literal: true

# == Schema Information
#
# Table name: nominees
#
#  id                         :bigint           not null, primary key
#  name                       :string(255)
#  status                     :integer          default("active")
#  nominee_type               :integer          default("primary")
#  dob                        :string(255)
#  relationship               :integer
#  kyc_id                     :bigint           not null
#  address_id                 :bigint
#  guardian_id                :bigint
#  relationship_with_guardian :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_nominees_on_address_id   (address_id)
#  index_nominees_on_guardian_id  (guardian_id)
#  index_nominees_on_kyc_id       (kyc_id)
#
require 'test_helper'

class NomineeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
