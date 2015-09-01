class AdminPanel::UserTrainingCoursesController < AdminPanel::BaseController
  before_action :set_training_course, only: :index
	before_action :set_user_training_course, only: [:applied, :disapplied]
  load_and_authorize_resource

  def index
    @user_training_courses = @training_course.user_training_courses
  end

  def list
    @user_training_courses = UserTrainingCourse.all
  end

  def applied
  	@user_training_course.update!(state: true)
  	return redirect_to admin_panel_user_training_courses_url
  end

  def disapplied
  	@user_training_course.update!(state: false)
  	return redirect_to admin_panel_user_training_courses_url
  end

  private
  def set_training_course
    @training_course = TrainingCourse.find(params[:training_course_id])
  end

  def set_user_training_course
  	@user_training_course = UserTrainingCourse.find(params[:id])
  end
end
