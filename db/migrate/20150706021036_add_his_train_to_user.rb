class AddHisTrainToUser < ActiveRecord::Migration
  def change
    add_column :users, :his_train, :text
  end
end
