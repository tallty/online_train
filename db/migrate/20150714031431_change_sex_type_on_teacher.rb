class ChangeSexTypeOnTeacher < ActiveRecord::Migration
  def change
    change_column :teachers, :sex, :boolean, default: true
  end
end
