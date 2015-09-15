class AddAdminRefToTrainingCourse < ActiveRecord::Migration
  def change
    add_reference :training_courses, :admin, index: true
  end
end
