class UserTrainingCoursesController < BaseController
	before_action :authenticate_user!, only: [:create]

  def create
  	@user_training_course = UserTrainingCourse.new(user_training_course_params)
    @user_training_course.state = nil
  	if @user_training_course.save
  		return render js: 'alert("报名成功！");window.location(history.go(0));'
  	else
  		return render js: 'alert("报名失败！");window.location(history.go(0));'
  	end
  end

  private
  def user_training_course_params
  	params.require(:user_training_course).permit(:user_id, :training_course_id, :certificate_no)
  end
end