# frozen_string_literal: true

# == Schema Information
#
# Table name: course_subjects
#
#  id         :bigint           not null, primary key
#  course_id  :bigint           not null
#  subject_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CourseSubjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
