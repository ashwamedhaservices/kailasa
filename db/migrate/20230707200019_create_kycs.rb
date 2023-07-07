# frozen_string_literal: true

class CreateKycs < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :kycs do |t|
      t.integer :status, limit: 1, default: 0
      t.string :name
      t.string :id_proof_no
      t.string :id_proof_url
      t.integer :id_proof_type, limit: 1
      t.string :address_proof_no
      t.string :address_proof_url
      t.integer :address_proof_type, limit: 1
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
