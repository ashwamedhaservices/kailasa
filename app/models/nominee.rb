# frozen_string_literal: true

# == Schema Information
#
# Table name: nominees
#
#  id                         :bigint           not null, primary key
#  name                       :string(255)
#  status                     :integer          default("active")
#  nominee_type               :integer          default(0)
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
class Nominee < ApplicationRecord
  belongs_to :kyc
  belongs_to :guardian, class_name: 'Nominee', optional: true
  belongs_to :address, optional: true

  enum status: { active: 0, inactive: 1 }
  enum nominee_type: { primary: 0, secondary: 1 }
  enum relationship: { self: 0, spouse: 1, child: 2, parent: 3, other: 4 }, _prefix: :relation_is
  enum relationship_with_guardian: { others: 0, parent: 1 }, _prefix: :guardian_is
end
