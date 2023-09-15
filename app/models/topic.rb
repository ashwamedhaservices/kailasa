# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id             :bigint           not null, primary key
#  name           :string(60)
#  description    :string(255)
#  image_url      :string(255)
#  photo_url      :string(255)
#  video_url      :string(255)
#  content_url    :string(255)
#  chapter_id     :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  video_duration :bigint
#  streaming_url  :string(255)
#  author_id      :bigint
#  notes_url      :string(255)
#
# Indexes
#
#  index_topics_on_author_id   (author_id)
#  index_topics_on_chapter_id  (chapter_id)
#
class Topic < ApplicationRecord
  belongs_to :chapter
  has_many :enrollments, dependent: :restrict_with_error
  has_many :question_papers, as: :testable, dependent: :nullify

  def question_paper
    question_papers.last.questions_with_answers
  end
end
