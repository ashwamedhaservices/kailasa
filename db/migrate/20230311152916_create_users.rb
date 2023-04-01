class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :title
      t.string :fname
      t.string :mname
      t.string :lname
      t.integer :iters
      t.string :salt
      t.string :password
      # t.string :password_digest
      t.string :email
      t.string :mobile_number, null: false, index: { unique: true }
      t.string :state, index: true
      t.string :type # STI //student, teacher, admin, super_admin
      t.string :referral_code
      t.references :referrer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
