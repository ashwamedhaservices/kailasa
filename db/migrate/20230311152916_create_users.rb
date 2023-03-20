class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :fname 
      t.string :mname
      t.string :lname
      t.string :password
      t.string :email
      t.string :mobile_number, :null =>  false, :index => true
      t.string :type # STI //student, teacher, admin, super_admin
      t.string :referral_code
      t.integer :referred_by
      
      t.timestamps
    end
  end
end
