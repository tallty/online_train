class AddBeAppliedToTrainingCourse < ActiveRecord::Migration
  def change
  	add_column(:training_courses, :be_applied, :boolean, default: false)
  end
end
