class AdminPanel::UserTrainingCoursesController < AdminPanel::BaseController
  before_action :set_training_course, only: [:index, :edit, :update, :applied, :disapplied, :add, :added]
	before_action :set_user_training_course, only: [:applied, :disapplied, :edit, :update, :add, :added]
  before_action :set_session, only: [:applied, :disapplied]
  load_and_authorize_resource

  def index
    @user_training_courses = @training_course.user_training_courses.keyword(params[:keyword])
                                                                    .page(params[:page]).per(15)
    @applied_user_training_courses = @training_course.user_training_courses.where(state: true)
    add_breadcrumb "培训报名列表"
  end

  def list
    @user_training_courses = UserTrainingCourse.all.page(params[:page]).per(15).keyword(params[:keyword])
    add_breadcrumb "报名列表"
  end

  def show
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

  #添加证书编号
  def add
    respond_to do |format|
      format.js
    end
  end

  def added
    @user_training_course.update(certificate_no: params[:user_training_course][:certificate_no])
    return render js: "window.location.href = '#{admin_panel_training_course_user_training_courses_path(@training_course)}';"
    respond_to do |format|
      format.js
    end
  end

  def applied
  	@user_training_course.update!(state: true)
    message = Message.create!(title: "已通过", content: "您报名的“#{@user_training_course.training_course.try(:name)}”已通过管理员审核")
    UserMessage.create!(user_id: @user_training_course.user.id, message_id: message.id)
  	return redirect_to session.delete(:return_to)
  end

  def disapplied
  	@user_training_course.update!(state: false)
    message = Message.create!(title: "未通过", content: "您报名的“#{@user_training_course.training_course.try(:name)}”未通过管理员审核")
    UserMessage.create!(user_id: @user_training_course.user.id, message_id: message.id)
  	return redirect_to session.delete(:return_to)
  end

  private
  def set_training_course
    @training_course = TrainingCourse.find(params[:training_course_id])
    @notification = @training_course.notification
  end

  def set_user_training_course
  	@user_training_course = UserTrainingCourse.find(params[:id])
  end

  #审核前保存请求地址
  def set_session
    session[:return_to] ||= request.referer
  end
end
