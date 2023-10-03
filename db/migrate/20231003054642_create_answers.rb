class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.timestamps
      t.text :value
      t.text :explanation
      t.boolean :correct, null: false, default: false

      t.references :question, null: false, foreign_key: true
    end
  end
end
