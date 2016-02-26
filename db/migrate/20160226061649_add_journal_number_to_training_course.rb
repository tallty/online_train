class AddJournalNumberToTrainingCourse < ActiveRecord::Migration
  def change
    add_column :training_courses, :journal_number, :integer
  end
end
