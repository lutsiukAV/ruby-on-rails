class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :mark
      t.string :comment

      t.timestamps null: false

      t.foreign_key :courses
      t.foreign_key :users
    end
  end
end
