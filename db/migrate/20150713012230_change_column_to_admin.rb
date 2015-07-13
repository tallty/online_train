class ChangeColumnToAdmin < ActiveRecord::Migration
  def change
    remove_column :admins, :province_manager
    remove_column :admins, :agency_manager
    remove_index :admins, :email


    add_column :admins, :username, :string 
    add_reference :admins, :adminable, polymorphic: true

    add_index :admins, :username, unique: true
  end
end
