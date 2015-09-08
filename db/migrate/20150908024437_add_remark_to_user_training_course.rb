class AddRemarkToUserTrainingCourse < ActiveRecord::Migration
  def change
    add_column :user_training_courses, :remark, :string
  end
end
