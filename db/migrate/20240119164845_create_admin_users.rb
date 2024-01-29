# frozen_string_literal: true

class CreateAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_users do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.integer :status, limit: 1, default: 0
      t.integer :role, limit: 1, default: 0
    end
  end
end
