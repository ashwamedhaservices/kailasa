# frozen_string_literal: true

class CreateCredits < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :credits do |t|
      t.timestamps
      t.references :users, null: false, foreign_key: true
      t.references :for_user, foreign_key: { to_table: :users }
      t.integer :status, limit: 1, default: 0
      t.integer :credit_type, limit: 1, default: 0
      t.float :amount
      t.integer :level
      t.datetime :date
    end

    add_index :credits, %i[users_id for_user_id credit_type]
  end
end
