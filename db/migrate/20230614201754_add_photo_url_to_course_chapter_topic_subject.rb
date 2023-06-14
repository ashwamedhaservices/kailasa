# frozen_string_literal: true

class AddPhotoUrlToCourseChapterTopicSubject < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :photo_url, :string, after: 'image_url'
    add_column :subjects, :photo_url, :string, after: 'image_url'
    add_column :chapters, :photo_url, :string, after: 'image_url'
    add_column :topics, :photo_url, :string, after: 'image_url'
  end
end
