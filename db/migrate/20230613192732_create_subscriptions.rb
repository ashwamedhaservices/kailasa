# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.integer :status, limit: 1, default: 0
      t.integer :kind, limit: 1, default: 0
      t.datetime :start_date
      t.datetime :end_date

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
