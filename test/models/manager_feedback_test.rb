# == Schema Information
#
# Table name: manager_feedbacks
#
#  id                  :integer          not null, primary key
#  admin_id            :integer
#  training_course_id  :integer
#  organizer           :string(255)
#  total_hours         :string(255)
#  total_expenses      :string(255)
#  total_expenses_info :text(65535)
#  feedback            :text(65535)
#  remark              :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ManagerFeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
