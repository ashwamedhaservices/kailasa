# frozen_string_literal: true

class ChangeQuestionsValueFromVarcharToText < ActiveRecord::Migration[7.0]
  def change
    safety_assured { change_column :questions, :value, :text } # rubocop:disable Rails/ReversibleMigration
  end
end
