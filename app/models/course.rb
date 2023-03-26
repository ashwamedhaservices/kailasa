# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :string(255)
#  image_url   :string(255)
#  price       :decimal(10, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Course < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
end
