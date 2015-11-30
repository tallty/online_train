# == Schema Information
#
# Table name: user_training_courses
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  state              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  remark             :string(255)
#  certificate_no     :string(255)
#

require 'test_helper'

class UserTrainingCourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
