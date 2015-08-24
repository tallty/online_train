class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.integer :classify, default: 1
      t.string :picture_url

      t.timestamps null: false
    end
  end
end
