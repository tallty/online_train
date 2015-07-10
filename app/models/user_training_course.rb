class UserTrainingCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course
end
