# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :subjects do |t|
      t.string :name, limit: 60
      t.string :description
      t.string :image_url

      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
