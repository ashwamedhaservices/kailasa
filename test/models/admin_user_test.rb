# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  status     :integer          default("inactive")
#  role       :integer          default("admin")
#
# Indexes
#
#  index_admin_users_on_user_id  (user_id)
#
require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
