class AddSchoolIdToTeacher < ActiveRecord::Migration
  def change
    remove_column :teachers, :province
    add_reference :teachers, :school
    
    add_column :teachers, :job_title, :string
  end
end
