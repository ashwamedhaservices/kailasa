# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :profiles do |t|
      t.string  :name
      t.integer :status, limit: 1, default: 0
      t.date    :dob
      t.integer :age, limit: 1

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
