# frozen_string_literal: true

# == Schema Information
#
# Table name: credits
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  users_id    :bigint           not null
#  for_user_id :bigint
#  status      :integer          default("credited")
#  credit_type :integer          default("partner")
#  amount      :float(24)
#  level       :integer
#  date        :datetime
#
# Indexes
#
#  index_credits_on_for_user_id                               (for_user_id)
#  index_credits_on_users_id                                  (users_id)
#  index_credits_on_users_id_and_for_user_id_and_credit_type  (users_id,for_user_id,credit_type)
#
require 'test_helper'

class CreditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
