# frozen_string_literal: true

# == Schema Information
#
# Table name: subject_chapters
#
#  id         :bigint           not null, primary key
#  subject_id :bigint           not null
#  chapter_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SubjectChapter < ApplicationRecord
  belongs_to :subject
  belongs_to :chapter
end
