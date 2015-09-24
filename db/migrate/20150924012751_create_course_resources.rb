class CreateCourseResources < ActiveRecord::Migration
  def change
    create_table :course_resources do |t|
      t.string :title
      t.text :remark
      t.references :training_course, index: true

      t.timestamps null: false
    end
  end
end
