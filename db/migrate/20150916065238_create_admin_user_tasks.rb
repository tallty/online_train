class CreateAdminUserTasks < ActiveRecord::Migration
  def change
    create_table :admin_user_tasks do |t|
      t.references :admin, index: true
      t.references :user_task, index: true
      t.decimal :score, precision: 5, scale: 2
      t.text :comment

      t.timestamps null: false
    end
  end
end
