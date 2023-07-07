class CreatePennyDrops < ActiveRecord::Migration[7.0]
  def change
    create_table :penny_drops do |t|
      t.string :name
      t.string :name_at_bank
      t.integer :status, limit: 1, default: 0
      t.string :remarks
      t.references :bank_accounts, null: false, foreign_key: true
      t.timestamps
    end
  end
end
