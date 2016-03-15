class CreateDivides < ActiveRecord::Migration
  def change
    create_table :divides do |t|
      t.references :training_course, index: true
      t.string :name
      t.string :header

      t.timestamps null: false
    end
  end
end
