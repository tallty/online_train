# == Schema Information
#
# Table name: admin_user_tasks
#
#  id           :integer          not null, primary key
#  admin_id     :integer
#  user_task_id :integer
#  score        :decimal(5, 2)
#  comment      :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class AdminUserTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
