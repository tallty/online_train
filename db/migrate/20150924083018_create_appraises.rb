class CreateAppraises < ActiveRecord::Migration
  def change
    create_table :appraises do |t|
      t.references :user, index: true
      t.references :teacher, index: true
      t.text :remark
      t.string :degree
      t.references :training_course, index: true

      t.timestamps null: false
    end
  end
end
