# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string  :name
      t.date    :dob
      t.integer :age, limit: 2

      t.timestamps
    end
  end
end
