# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id                 :bigint           not null, primary key
#  name               :string(255)
#  status             :integer          default("created")
#  address_type       :integer          default("home")
#  address_line_one   :string(255)
#  address_line_two   :string(255)
#  address_line_three :string(255)
#  city               :string(255)
#  state              :string(255)
#  country            :string(255)
#  postal_code        :string(255)
#  kyc_id             :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_addresses_on_kyc_id  (kyc_id)
#
class Address < ApplicationRecord
  belongs_to :kyc

  enum status: { created: 0, active: 1, disabled: 2 }
  enum address_type: { home: 0, work: 1, billing: 2, shipping: 3 }
end
