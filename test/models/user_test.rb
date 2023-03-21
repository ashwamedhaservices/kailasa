# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  fname         :string(255)
#  mname         :string(255)
#  lname         :string(255)
#  password      :string(255)
#  email         :string(255)
#  mobile_number :string(255)      not null
#  type          :string(255)
#  referral_code :string(255)
#  referred_by   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
