class AdminPanel::JournalsController < AdminPanel::BaseController
  load_and_authorize_resource

  def index
  	@user_training_course = UserTrainingCourse.find(params[:user_training_course_id])
  	@journals = Journal.where(user_id: @user_training_course.user_id, training_course_id: @user_training_course.training_course_id).page(params[:page]).per(15)
  end

  def list
    @journals = Journal.all.keyword(params[:keyword])
                           .page(params[:page]).per(15)
  end

  def show
  	@journal = Journal.find(params[:id])
  end
end
