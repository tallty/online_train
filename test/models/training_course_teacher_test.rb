# == Schema Information
#
# Table name: training_course_teachers
#
#  id                 :integer          not null, primary key
#  training_course_id :integer
#  teacher_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class TrainingCourseTeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
