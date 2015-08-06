class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :training_course, index: true
      t.string :title
      t.string :sub_title
      t.integer :view_count, default: 0
      t.string :author
      t.text :content
      t.string :category

      t.timestamps null: false
    end
  end
end
