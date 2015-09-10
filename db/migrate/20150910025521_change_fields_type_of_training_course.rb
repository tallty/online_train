class ChangeFieldsTypeOfTrainingCourse < ActiveRecord::Migration
  def change
  	change_column :training_courses, :info, :text
  	change_column :training_courses, :training_background, :text
  	change_column :training_courses, :training_target, :text
  end
end