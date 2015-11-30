# == Schema Information
#
# Table name: journals
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  title              :string(255)
#  content            :text(65535)
#  add_date           :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class JournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
