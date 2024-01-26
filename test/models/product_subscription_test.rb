# frozen_string_literal: true

# == Schema Information
#
# Table name: product_subscriptions
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#  user_category  :integer          default("user")
#  name           :string(255)
#  status         :integer          default("unsubscribed")
#  category       :integer          default("na")
#  amount         :float(24)
#  referral_count :integer
#
# Indexes
#
#  index_product_subscriptions_on_user_id  (user_id)
#
require 'test_helper'

class ProductSubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
