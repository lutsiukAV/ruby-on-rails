class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.integer :group

      t.timestamps null: false
    end
  end
end
