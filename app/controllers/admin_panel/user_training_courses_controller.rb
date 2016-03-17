class AdminPanel::UserTrainingCoursesController < AdminPanel::BaseController
  before_action :set_training_course, only: [:index, :edit, :update, :applied, :disapplied, :add, :added, :update_multiple]
	before_action :set_user_training_course, only: [:applied, :disapplied, :edit, :update, :add, :added, :delete, :restore]
  before_action :set_session, only: [:applied, :disapplied]
  skip_before_action :verify_authenticity_token, only: :update_multiple
  load_and_authorize_resource

  def index
    @user_training_courses = UserTrainingCourse.enabled.where({training_course_id: @training_course.id})
                                               .by_role(params[:role])
                                               .by_divide(params[:divide_id])
                                               .get_user_training_course(@training_course, params[:status])
                                               .keyword(params[:keyword])
                                               .page(params[:page]).per(15)
    #达标
    @reached_user_training_courses_length = @training_course.reached_journal_number.length
    #未达标
    @unreached_user_training_courses_length = @training_course.unreached_journal_number.length

    @applied_user_training_courses = @training_course.user_training_courses.where(state: true)

    respond_to do |format|
      format.html
      format.xls{
        send_data( xls_content_for(@user_training_courses, @applied_user_training_courses, @training_course),
          :type => "text/excel;charset=utf-8; header=present",
          :filename => "学员报名表(#{Time.now.strftime("%F %H%M%S")}).xls" )
      }
    end
  end

  def list
    @user_training_courses = UserTrainingCourse.enabled.page(params[:page]).per(15).keyword(params[:keyword])
    @role_count = UserTrainingCourse.role_count
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

  #批量处理
  def update_multiple
    if UserTrainingCourse.where({id: params[:user_training_course]}).update_all(divide_id: params[:divide_id])
      p params[:divide_id]
      UserTrainingCourse.where({id: params[:user_training_course]}).each do |user_training_course|
        message = Message.create!(title: "报名分组", content: "您已经被分配到“#{user_training_course.training_course.try(:name)}” #{user_training_course.try(:divide).try(:name)}")
        UserMessage.create!(user_id: user_training_course.user.id, message_id: message.id)
      end
      flash[:notice] = "处理成功"
      return redirect_to admin_panel_training_course_user_training_courses_path(@training_course)
    else
      flash[:notice] = "处理失败"
      return redirect_to admin_panel_training_course_user_training_courses_path(@training_course)
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

  def delete
    @user_training_course.update(deleted_at: Time.now)
    flash[:notice] = '删除成功'
    redirect_to admin_panel_training_course_user_training_courses_path(@training_course)
  end

  # def restore
  #   @user_training_course.update(deleted_at: nil)
  #   flash[:notice] = '恢复成功'
  #   redirect_to admin_panel_training_course_user_training_courses_path(@training_course)
  # end

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

  # 导出为xls
  def xls_content_for(objs, applied_user_training_courses, training_course)
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "学员报名表"

    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
    sheet1.row(0).default_format = blue

    sheet1.row(0).concat %w{序号 培训班 姓名 账号(邮箱) 性别 出生年月 地址 手机 职位分类 学校 院系 专业 职称 职务 报名时间 状态}
    count_row = 1
      objs.each do |obj|
      sheet1[count_row, 0] = count_row
      sheet1[count_row, 1] = obj.try(:training_course).try(:name)
      sheet1[count_row, 2] = obj.try(:user).try(:name)
      sheet1[count_row, 3] = obj.try(:user).try(:email)
      sheet1[count_row, 4] = User::UserGender[obj.try(:user).try(:gender).to_sym]
      sheet1[count_row, 5] = obj.try(:user).try(:birth).try{|b| b.strftime("%F")}
      sheet1[count_row, 6] = obj.try(:user).try(:address)
      sheet1[count_row, 7] = obj.try(:user).try(:phone)
      sheet1[count_row, 8] = User::ROLE[obj.try(:user).try(:role).try{|r| r.to_sym}]
      sheet1[count_row, 9] = obj.try(:user).try(:school)
      sheet1[count_row, 10] = obj.try(:user).try(:academy)
      sheet1[count_row, 11] = obj.try(:user).try(:profession)
      sheet1[count_row, 12] = obj.try(:user).try(:position_name)
      sheet1[count_row, 13] = obj.try(:user).try(:position)
      sheet1[count_row, 14] = obj.try(:created_at).strftime("%Y-%m-%d %H:%M:%S")
      if obj.state == nil
        sheet1[count_row, 14] = "待审核"
      elsif obj.state == false
        sheet1[count_row, 14] = "未通过"
      elsif obj.state == true
        sheet1[count_row, 14] = "已通过"
      else training_course.plan_number.to_i - applied_user_training_courses.count <= 0
        sheet1[count_row, 14] = "未通过"
      end
      count_row += 1
    end

    book.write xls_report
    xls_report.string
  end
end
