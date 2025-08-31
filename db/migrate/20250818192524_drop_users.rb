class DropUsers < ActiveRecord::Migration[7.2]
  def down
    create_table :users do |t|
      t.string :first_name
      t.string :second_name
      t.integer :role

      t.timestamps
    end
  end

  def up
    drop_table :users
  end
end
