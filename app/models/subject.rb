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
class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :subject_chapters, dependent: :destroy
  has_many :chapters, through: :subject_chapters
end
