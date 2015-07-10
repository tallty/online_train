class CreateUserTrainingCourses < ActiveRecord::Migration
  def change
    create_table :user_training_courses do |t|
      t.references :user, index: true, foreign_key: true
      t.references :training_course, index: true, foreign_key: true
      t.string :state

      t.timestamps null: false
    end
  end
end
