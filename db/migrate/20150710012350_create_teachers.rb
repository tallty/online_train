class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :id_card
      t.string :province
      t.string :position
      t.string :sex
      t.text :remark
      t.string :address
      t.string :mobile
      t.string :phone
      t.string :qq
      t.string :email
      t.string :postcode

      t.timestamps null: false
    end
  end
end
