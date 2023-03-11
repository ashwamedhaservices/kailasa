class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :phone, :null =>  false, :index => true
      t.string :name
      t.string :code
      
      t.timestamps
    end
  end
end
