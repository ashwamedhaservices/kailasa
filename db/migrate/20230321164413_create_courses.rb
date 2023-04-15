# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :courses do |t|
      t.string :name, limit: 60
      t.string :description
      t.string :image_url
      t.integer :status, limit: 1, default: 0
      t.decimal :price
      t.integer :language, limit: 2, default: 0
      t.integer :level, limit: 1, default: 0
      t.float :hours
      t.integer :topic_count
      t.integer :enrolled, limit: 8

      t.timestamps
    end
  end
end
