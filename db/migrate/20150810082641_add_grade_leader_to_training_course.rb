class AddGradeLeaderToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :grade_leader, :string
  end
end
