class AdminPanel::JournalsController < AdminPanel::BaseController
  load_and_authorize_resource

  def index
  	user_training_course = UserTrainingCourse.find(params[:user_training_course_id])
  	@journals = Journal.where(user_id: user_training_course.user_id, training_course_id: user_training_course.training_course_id)
  end

  def list
  end
end
