# frozen_string_literal: true

class CreateNominees < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :nominees do |t|
      t.string :name
      t.integer :status, limit: 1, default: 0
      t.integer :nominee_type, limit: 1, default: 0
      t.string :dob
      t.integer :relationship, limit: 1
      t.references :kyc, null: false, foreign_key: true
      t.references :address, foreign_key: true
      t.references :guardian, foreign_key: { to_table: :nominees }
      t.integer :relationship_with_guardian, limit: 1
      t.timestamps
    end
  end
end
