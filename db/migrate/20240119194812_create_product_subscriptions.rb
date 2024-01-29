# frozen_string_literal: true

class CreateProductSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_subscriptions do |t|
      t.timestamps
      t.references :user, foreign_key: true, null: false
      t.integer :user_category, limit: 1, default: 0
      t.string :name
      t.integer :status, limit: 1, default: 0
      t.integer :category, limit: 1, default: 0
      t.float :amount
      t.integer :referral_count
    end
  end
end
