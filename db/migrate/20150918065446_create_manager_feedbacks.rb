class CreateManagerFeedbacks < ActiveRecord::Migration
  def change
    create_table :manager_feedbacks do |t|
      t.references :admin, index: true, foreign_key: true
      t.references :training_course, index: true, foreign_key: true
      t.string :organizer
      t.string :total_hours
      t.string :total_expenses
      t.text :total_expenses_info
      t.text :feedback
      t.text :remark

      t.timestamps null: false
    end
  end
end
