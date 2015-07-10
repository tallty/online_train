# == Schema Information
#
# Table name: user_training_courses
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  state              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class UserTrainingCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course
end
