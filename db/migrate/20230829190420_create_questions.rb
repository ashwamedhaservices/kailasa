# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.timestamps
      t.string :value
      t.integer :question_type, limit: 1, default: 0
    end
  end
end
