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
require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
