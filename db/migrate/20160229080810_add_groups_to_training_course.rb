class AddGroupsToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :groups, :string
  end
end
