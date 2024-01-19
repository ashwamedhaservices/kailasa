# == Schema Information
#
# Table name: product_referrals
#
#  id                      :bigint           not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_subscription_id :bigint           not null
#  user_id                 :bigint           not null
#  referred_user_id        :bigint           not null
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
end
