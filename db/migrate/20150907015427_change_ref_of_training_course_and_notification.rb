class ChangeRefOfTrainingCourseAndNotification < ActiveRecord::Migration
  def change
  	remove_reference :notifications, :training_course, index: true
  	add_reference :training_courses, :notification, index: true
  end
end
