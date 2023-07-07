# frozen_string_literal: true

# == Schema Information
#
# Table name: nominees
#
#  id                         :bigint           not null, primary key
#  name                       :string(255)
#  status                     :integer          default(0)
#  type                       :integer          default(0)
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
end
