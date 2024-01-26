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
class ProductSubscription < ApplicationRecord
  belongs_to :user
  has_many :product_referrals, dependent: :destroy

  # user: basic user who has been referred by someone
  # admin: core admin for the product
  # fdo: field development officer he has been appointed by the admin and has special powers
  enum user_category: { user: 0, admin: 1, fdo: 2 }
  enum status: { unsubscribed: 0, subscribed: 1 }

  # product_details.yml contains details about the category
  # this enum and credits credit_type needs to be in sync
  # na: not applicable
  # tv: subscription for tv
  # ev: subscription for electric vehicle
  enum category: { na: 0, tv: 1, ev: 2 }
end
