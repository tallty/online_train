class AddCountryToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    remove_column :users, :city
  end
end
