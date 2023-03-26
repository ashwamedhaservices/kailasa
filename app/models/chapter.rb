# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id          :bigint           not null, primary key
#  name        :string(255)
#  description :string(255)
#  image_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Chapter < ApplicationRecord
  has_many :subject_chapters, dependent: :destroy
  has_many :subjects, through: :subject_chapters
end
