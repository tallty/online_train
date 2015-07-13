class AddColumnToAdmins < ActiveRecord::Migration
  def change
    rename_column :admins, :roles, :role
    change_column :admins, :role, :integer
  end
end
