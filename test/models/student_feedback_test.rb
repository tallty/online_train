# == Schema Information
#
# Table name: student_feedbacks
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  teach              :string(255)
#  discussion         :string(255)
#  visiting           :string(255)
#  organization       :string(255)
#  study_life         :string(255)
#  most_value         :text(65535)
#  most_gain          :text(65535)
#  graduate_message   :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class StudentFeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
