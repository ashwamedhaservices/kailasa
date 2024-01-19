class CreateProductReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :product_referrals do |t|
      t.timestamps
      t.references :product_subscription, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :referred_user, null: false, foreign_key: { to_table: :users }
    end
  end
end
