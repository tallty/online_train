class AddFieldsToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :linkman, :string
    add_column :training_courses, :phone, :string
    add_column :training_courses, :fax, :string
    add_column :training_courses, :mobile, :string
    add_column :training_courses, :email, :string
  end
end
