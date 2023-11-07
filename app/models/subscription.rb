# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  status     :integer          default("pending")
#  kind       :integer          default("unsubscribed")
#  start_date :datetime
#  end_date   :datetime
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
class Subscription < ApplicationRecord
  has_paper_trail

  belongs_to :user
  has_many :payments, dependent: :restrict_with_error

  enum :kind, %i[unsubscribed seven_days one_year]
  enum :status, %i[pending active inactive]

  SUBSCRIPTION_PERIOD = {
    unsubscribed: 0,
    seven_days: 7.days,
    one_year: 1.year
  }.with_indifferent_access.freeze

  def self.period(kind)
    SUBSCRIPTION_PERIOD[kind]
  end
end
