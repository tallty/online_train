# == Schema Information
#
# Table name: course_resources
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  remark             :text(65535)
#  training_course_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class CourseResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
