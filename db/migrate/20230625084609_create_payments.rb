# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :payments do |t|
      t.string :amount
      t.integer :status, limit: 1, default: 0
      t.integer :mode, limit: 1
      t.integer :platform, limit: 1
      t.integer :for, limit: 1
      t.string :notes
      t.string :pg_transaction_no
      t.string :txn_reference_no
      t.datetime :settlement_time
      t.datetime :refund_time
      t.references :user, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.references :payment_gateway, null: false, foreign_key: true
      t.timestamps
    end
  end
end
