class AddStartApplyTimeAndEndApplyTimeToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :start_apply_time, :datetime
    add_column :training_courses, :end_apply_time, :datetime
  end
end
