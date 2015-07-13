class TrainingCoursesController < ApplicationController
  def index
  	@training_courses = TrainingCourse.all.page(params[:page]).per(15)
  end

  def show
  	@training_course = TrainingCourse.find(params[:id])
  	@present_user_training_course = UserTrainingCourse.where(user_id: current_user.id, training_course_id: @training_course.id).first
  end
end
