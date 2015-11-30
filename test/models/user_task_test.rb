# == Schema Information
#
# Table name: user_tasks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  title      :string(255)
#  content    :string(255)
#  appraise   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
