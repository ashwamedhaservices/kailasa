# frozen_string_literal: true

class CreateProductReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :product_referrals do |t|
      t.timestamps
      t.references :product_subscription, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :referred_user, null: false, foreign_key: { to_table: :users }
      t.string :referred_user_name
      t.string :referred_user_email
      t.string :referred_user_mobile_number
    end
  end
end
