class UserController < BaseController
  before_action :authenticate_user!

  def my
    @user = current_user
  end

  def course
    now = Time.now
    #正在进行的课程
    on_training_course_ids = TrainingCourse.where("start_time <= ? AND end_time >= ?", now, now).pluck(:id)
    @on_user_training_courses = current_user.user_training_courses.where({training_course_id: on_training_course_ids})
    #即将开始的课程
    be_training_course_ids = TrainingCourse.where("start_time > ?", now).pluck(:id)
    @be_user_training_courses = current_user.user_training_courses.where({training_course_id: be_training_course_ids})
  end

  def end_course
    #已完成的课程
    now = Time.now
    already_training_course_ids = TrainingCourse.where("end_time < ?", now).pluck(:id)
    @already_user_training_courses = current_user.user_training_courses.where({training_course_id: already_training_course_ids})
  end

  def message
    @messages = current_user.messages.order("created_at desc").page(params[:page]).per(20)
  end

  def work
    now = Time.now
    #正在进行的课程才能提交作业
    on_training_course_ids = TrainingCourse.pluck(:id)
    @user_training_courses = current_user.user_training_courses.where({training_course_id: on_training_course_ids}).where(state: true)
  end

  def journal
    @journals = Journal.where(user_id: current_user.id)
                       .order("add_date asc")
                       .page(params[:page]).per(15)
  end

  def update
    @user = User.where(id: params[:id]).first
    @user.is_vaild = true
    #未查找到对应数据时处理
    if @user.blank?
      flash[:error] = "当前个人资料不存在"
      redirect_to user_index_path
    end

    if @user.update(user_params)
      #更新成功
      #重新登录更新session以及current_user等相关变量方法的值
      sign_in(:user, @user)
      flash[:notice] = "个人资料更新成功"
      redirect_to my_user_index_path
    else
      #更新失败
      render :my
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,:ID_number, :nation, :gender, :birth, :school, :academy, :profession, :certificate,
                                  :position_name, :position, :address, :zip_code, :telephone, :phone,
                                  :qq_no, :summary, :country, :his_train, :role)
    end

end
