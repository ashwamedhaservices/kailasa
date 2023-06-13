# frozen_string_literal: true

class ChangeUserTypeToInteger < ActiveRecord::Migration[7.0]
  def change
    safety_assured { change_column :users, :type, :integer, limit: 1 }  # rubocop:disable Rails/ReversibleMigration
  end
end
