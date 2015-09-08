class ChangeTrainingFeeOfTrainingCourse < ActiveRecord::Migration
  def change
  	change_column(:training_courses, :training_fee, :decimal, :precision => 10, :scale => 2)
  end
end
