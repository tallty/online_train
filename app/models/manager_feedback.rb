class ManagerFeedback < ActiveRecord::Base
  belongs_to :admin
  belongs_to :training_course
end
