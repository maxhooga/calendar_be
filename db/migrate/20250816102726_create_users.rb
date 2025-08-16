class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :second_name
      t.integer :role

      t.timestamps
    end
  end
end
