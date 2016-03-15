class AddDivideRefToUserTrainingCourse < ActiveRecord::Migration
  def change
    add_reference :user_training_courses, :divide, index: true
  end
end
