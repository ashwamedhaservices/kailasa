# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :bank_accounts do |t|
      t.string :account_number
      t.integer :status, limit: 1, default: 0
      t.integer :account_type, limit: 1, default: 0
      t.string :ifsc
      t.string :micr
      t.string :bank
      t.string :branch
      t.string :city
      t.integer :proof_type, limit: 1, default: 0
      t.string :proof_url
      t.references :kyc, foreign_key: true
      t.timestamps
    end
    add_index :bank_accounts, :account_number
  end
end
