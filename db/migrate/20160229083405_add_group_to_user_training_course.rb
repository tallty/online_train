class AddGroupToUserTrainingCourse < ActiveRecord::Migration
  def change
    add_column :user_training_courses, :group, :string
  end
end
