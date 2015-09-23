class CreateStudentFeedbacks < ActiveRecord::Migration
  def change
    create_table :student_feedbacks do |t|
      t.references :user, index: true
      t.references :training_course, index: true
      t.string :teach
      t.string :discussion
      t.string :visiting
      t.string :organization
      t.string :study_life
      t.text :most_value
      t.text :most_gain
      t.text :graduate_message

      t.timestamps null: false
    end
  end
end
