# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :string(255)
#  image       :string(255)
#  price       :decimal(10, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
