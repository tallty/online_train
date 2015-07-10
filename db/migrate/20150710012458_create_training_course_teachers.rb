class CreateTrainingCourseTeachers < ActiveRecord::Migration
  def change
    create_table :training_course_teachers do |t|
      t.references :training_course, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
