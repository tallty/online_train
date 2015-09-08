class AdminPanel::UserTrainingCoursesController < AdminPanel::BaseController
  before_action :set_training_course
	before_action :set_user_training_course, only: [:applied, :disapplied, :edit, :update]
  load_and_authorize_resource

  def index
    @user_training_courses = @training_course.user_training_courses.keyword_like(params[:keyword])
    # @search = UserTrainingCourse.where(training_course_id: @training_course.id).search do
    #   fulltext(params[:q]) do
    #     fields(:user_name, :user_email, :user_phone)
    #   end
    # end
  end

  def list
    @search = UserTrainingCourse.search do
      fulltext(params[:q]) do
        fields(:user_name, :user_email, :user_phone)
      end
    end
  end

  def applied
  	@user_training_course.update!(state: true)
  	return redirect_to admin_panel_user_training_courses_url
  end

  def edit
  end

  def update
    if @user_training_course.update!(remark: params[:user_training_course][:remark])
      flash[:notice] = "备注信息修改成功"
      return redirect_to admin_panel_training_course_user_training_courses_path(@training_course)
    else
      flash[:notice] = "备注信息修改失败"
      return render action: :edit
    end
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
