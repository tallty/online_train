class AddContactToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :contact, :string
  end
end
