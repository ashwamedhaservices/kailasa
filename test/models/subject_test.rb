# frozen_string_literal: true

# == Schema Information
#
# Table name: subjects
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :string(255)
#  image_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
