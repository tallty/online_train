class AddCategoryToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :category, :string
  end
end
