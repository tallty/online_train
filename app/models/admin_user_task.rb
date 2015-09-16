class AdminUserTask < ActiveRecord::Base
  belongs_to :admin
  belongs_to :user_task
  attr_accessor :admin_ids
end
