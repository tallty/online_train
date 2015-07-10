class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :submit_user_count, default: 0
      t.references :training_course, index: true, null: false
      t.references :admin, index: true, null: false

      t.timestamps null: false
    end
  end
end
