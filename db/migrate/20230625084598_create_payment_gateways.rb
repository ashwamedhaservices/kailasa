# frozen_string_literal: true

class CreatePaymentGateways < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_gateways do |t|
      t.string :name
      t.integer :status, limit: 1, default: 0
      t.string :api_key
      t.string :secret
      t.string :success_url
      t.string :failure_url
      t.timestamps
    end
  end
end
