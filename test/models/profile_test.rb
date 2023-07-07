# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  status     :integer          default("created")
#  dob        :date
#  age        :integer
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
