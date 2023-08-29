# frozen_string_literal: true

class CreateQuestionSets < ActiveRecord::Migration[7.0]
  def change
    create_table :question_sets do |t|
      t.timestamps
      t.string :name, null: false
      t.references :questionable, polymorphic: true, null: false
    end
  end
end
