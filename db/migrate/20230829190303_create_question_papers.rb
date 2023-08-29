# frozen_string_literal: true

class CreateQuestionPapers < ActiveRecord::Migration[7.0]
  def change
    create_table :question_papers do |t|
      t.timestamps

      t.string :name, null: false
      t.text :notes
      t.references :testable, polymorphic: true, null: false
    end
  end
end
