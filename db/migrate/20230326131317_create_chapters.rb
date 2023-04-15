# frozen_string_literal: true

class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :name, limit: 60
      t.string :description
      t.string :image_url

      t.references :subject, null: false, foreign_key: true
      t.timestamps
    end
  end
end
