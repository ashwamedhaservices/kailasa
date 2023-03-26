# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
