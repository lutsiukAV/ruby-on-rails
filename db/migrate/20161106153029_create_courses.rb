class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :user_id
      t.integer :hours

      t.timestamps null: false
      t.foreign_key :users
    end
  end
end
