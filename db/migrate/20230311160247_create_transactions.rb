class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.float :balance
      t.string :ref_no
      t.datetime :date
      t.string :type
      t.references :wallets
      
      t.timestamps
    end
  end
end
