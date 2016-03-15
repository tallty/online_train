class DropGroupFields < ActiveRecord::Migration
  def change
    remove_column(:user_training_courses, :group)
    remove_column(:training_courses, :groups)
  end
end
