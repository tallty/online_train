class AddTaskEndTimeToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :task_end_time, :datetime
  end
end
