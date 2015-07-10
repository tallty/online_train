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

class TrainingCourseTeacher < ActiveRecord::Base
  belongs_to :training_course
  belongs_to :teacher
end
