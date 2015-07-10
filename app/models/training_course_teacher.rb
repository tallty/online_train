class TrainingCourseTeacher < ActiveRecord::Base
  belongs_to :training_course
  belongs_to :teacher
end
