# frozen_string_literal: true

# == Schema Information
#
# Table name: credits
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#  for_user_id :bigint
#  status      :integer          default("credited")
#  credit_type :integer          default("partner")
#  amount      :float(24)
#  level       :integer
#  date        :datetime
#
# Indexes
#
#  index_credits_on_for_user_id                              (for_user_id)
#  index_credits_on_user_id                                  (user_id)
#  index_credits_on_user_id_and_for_user_id_and_credit_type  (user_id,for_user_id,credit_type)
#
class Credit < ApplicationRecord
  belongs_to :user
  belongs_to :for_user, class_name: 'User', optional: true

  # credited: money has been added to the wallet
  # processed:
  # paid: money that has been paid to bank account
  # debited: money has been taken from the wallet
  enum status: { credited: 0, processed: 1, paid: 3, debited: 4 }

  # this enum and product_subscriptions category needs to be in sync
  # partner: refered user for app
  # user:
  # tv: referred for tv
  # ev: referred for ev
  enum credit_type: { partner: 0, user: 1, tv: 3, ev: 4 }
end
