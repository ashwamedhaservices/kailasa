# frozen_string_literal: true

# == Schema Information
#
# Table name: product_referrals
#
#  id                          :bigint           not null, primary key
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  product_subscription_id     :bigint           not null
#  user_id                     :bigint           not null
#  referred_user_id            :bigint           not null
#  referred_user_name          :string(255)
#  referred_user_email         :string(255)
#  referred_user_mobile_number :string(255)
#
# Indexes
#
#  index_product_referrals_on_product_subscription_id  (product_subscription_id)
#  index_product_referrals_on_referred_user_id         (referred_user_id)
#  index_product_referrals_on_user_id                  (user_id)
#
class ProductReferral < ApplicationRecord
  belongs_to :product_subscription
  belongs_to :user
  belongs_to :referred_user, class_name: 'User'

  def refer(user, referred_user)
    self.user_id = user.id
    self.referred_user_id = referred_user.id
    self.referred_user_name = referred_user.full_name
    self.referred_user_email = referred_user.email
    self.referred_user_mobile_number = referred_user.mobile_number
    self
  end
end
