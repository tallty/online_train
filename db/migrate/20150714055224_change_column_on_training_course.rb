class ChangeColumnOnTrainingCourse < ActiveRecord::Migration
  def change
    remove_column :training_courses, :training_agency
    remove_column :training_courses, :grade_leader
    
    add_reference :training_courses, :school
    add_column :training_courses, :aasm_state, :string
  end
end
