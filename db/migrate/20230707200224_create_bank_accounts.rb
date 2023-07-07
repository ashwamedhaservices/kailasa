# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :bank_accounts do |t|
      t.string :account_number
      t.integer :status, limit: 1, default: 0
      t.integer :type, limit: 1, default: 0
      t.string :ifsc
      t.string :micr
      t.integer :proof_type, limit: 1, default: 0
      t.string :proof_url
      t.references :users, foreign_key: true
      t.timestamps
    end
    add_index :bank_accounts, :account_number
  end
end
