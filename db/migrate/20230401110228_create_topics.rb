# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :topics do |t|
      t.string :name, limit: 60
      t.string :description
      t.string :image_url
      t.string :video_url
      t.string :content_url

      t.references :chapter, null: false, foreign_key: true
      t.timestamps
    end
  end
end
