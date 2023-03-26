# frozen_string_literal: true

class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
