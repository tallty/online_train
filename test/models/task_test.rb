# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  body               :text(65535)      not null
#  submit_user_count  :integer          default(0)
#  training_course_id :integer          not null
#  admin_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
