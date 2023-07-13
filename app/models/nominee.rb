# frozen_string_literal: true

# == Schema Information
#
# Table name: nominees
#
#  id                         :bigint           not null, primary key
#  name                       :string(255)
#  status                     :integer          default("active")
#  type                       :integer          default("primary")
#  dob                        :string(255)
#  relationship               :integer
#  kycs_id                    :bigint           not null
#  addresses_id               :bigint
#  guardian_id                :bigint
#  relationship_with_guardian :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_nominees_on_addresses_id  (addresses_id)
#  index_nominees_on_guardian_id   (guardian_id)
#  index_nominees_on_kycs_id       (kycs_id)
#
class Nominee < ApplicationRecord
  belongs_to :kyc
  has_one :guardian, class_name: 'Nominee', foreign_key: 'guardian_id', dependent: :restrict_with_error,
                     inverse_of: :guardian

  enum status: { active: 0, inactive: 1 }
  enum type: { primary: 0, secondary: 1 }
  enum relationship: { self: 0, spouse: 1, child: 2, parent: 3, other: 4 }, _prefix: :relationship_is
  enum relationship_with_guardian: { self: 0, spouse: 1, child: 2, parent: 3, other: 4 },
       _prefix: :relationship_with_guardian_is
end
