# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  dob        :date
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
