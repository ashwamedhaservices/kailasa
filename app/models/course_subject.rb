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
class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
end
