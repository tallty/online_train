class AddFieldsToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :catalog, :integer
    add_column :materials, :mdate, :string
  end
end
