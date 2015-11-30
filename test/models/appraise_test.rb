# == Schema Information
#
# Table name: appraises
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  teacher_id         :integer
#  remark             :text(65535)
#  degree             :string(255)
#  training_course_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class AppraiseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
