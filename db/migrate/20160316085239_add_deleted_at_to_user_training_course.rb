class AddDeletedAtToUserTrainingCourse < ActiveRecord::Migration
  def change
    add_column :user_training_courses, :deleted_at, :datetime
  end
end
