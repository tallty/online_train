class ChangeStateTypeOfUserTrainingCourse < ActiveRecord::Migration
  def change
  	change_column(:user_training_courses, :state, :boolean, default: false)
  end
end
