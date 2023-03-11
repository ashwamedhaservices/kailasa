class CreateReferrals < ActiveRecord::Migration[7.0]
  def change
    create_table :referrals do |t|
      t.integer :referrer_id
      t.integer :referee_id

      t.timestamps
    end
  end
end
