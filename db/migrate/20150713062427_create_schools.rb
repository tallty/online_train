class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :username
      t.string :name
      t.references :province

      t.timestamps null: false
    end
  end
end
