class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|
      t.integer :referrer_id
      t.integer :referee_id
      t.integer :plan

      t.timestamps
    end
  end
end
