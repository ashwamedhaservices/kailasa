# frozen_string_literal: true

# == Schema Information
#
# Table name: penny_drops
#
#  id               :bigint           not null, primary key
#  name             :string(255)
#  name_at_bank     :string(255)
#  status           :integer          default(0)
#  remarks          :string(255)
#  bank_accounts_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_penny_drops_on_bank_accounts_id  (bank_accounts_id)
#
require 'test_helper'

class PennyDropTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
