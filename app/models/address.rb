# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id                 :bigint           not null, primary key
#  name               :string(255)
#  status             :integer          default(0)
#  type               :integer          default(0)
#  address_line_one   :string(255)
#  address_line_two   :string(255)
#  address_line_three :string(255)
#  city               :string(255)
#  state              :string(255)
#  country            :string(255)
#  postal_code        :string(255)
#  kycs_id            :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_addresses_on_kycs_id  (kycs_id)
#
class Address < ApplicationRecord
end
