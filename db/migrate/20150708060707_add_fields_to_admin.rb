class AddFieldsToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :name, :string
    add_column :admins, :province_manager, :string
    add_column :admins, :agency_manager, :string
    add_column :admins, :roles, :string
    add_column :admins, :qq, :string
    add_column :admins, :mobile, :string
    add_column :admins, :state, :string
    add_column :admins, :phone, :string
    add_column :admins, :address, :string
    add_column :admins, :postcode, :string
    add_column :admins, :remark, :text
  end
end
