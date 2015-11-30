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
    @user_training_courses = UserTrainingCourse.all.page(params[:page]).per(15).keyword(params[:keyword])
    @role_count = UserTrainingCourse.role_count
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

  # 导出为xls
  def xls_content_for(objs, applied_user_training_courses, training_course)
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "学员报名表"

    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
    sheet1.row(0).default_format = blue

    sheet1.row(0).concat %w{序号 姓名 账号 性别 职位分类 地址 手机 邮箱 学校 院系 报名时间 状态}
    count_row = 1
      objs.each do |obj|
      sheet1[count_row, 0] = count_row
      sheet1[count_row, 1] = obj.try(:user).try(:name)
      sheet1[count_row, 2] = obj.try(:user).try(:email)
      sheet1[count_row, 3] = User::UserGender[obj.try(:user).try(:gender).to_sym]
      sheet1[count_row, 4] = User::ROLE[obj.try(:user).try(:role).to_sym]
      sheet1[count_row, 5] = obj.try(:user).try(:address)
      sheet1[count_row, 6] = obj.try(:user).try(:phone)
      sheet1[count_row, 7] = obj.try(:user).try(:email)
      sheet1[count_row, 8] = obj.try(:user).try(:school)
      sheet1[count_row, 9] = obj.try(:user).try(:academy)
      sheet1[count_row, 10] = obj.try(:created_at).strftime("%Y-%m-%d %H:%M:%S")
      if obj.state == nil
        sheet1[count_row, 11] = "待审核"
      elsif obj.state == false
        sheet1[count_row, 11] = "未通过"
      elsif obj.state == true
        sheet1[count_row, 11] = "已通过"
      else training_course.plan_number.to_i - applied_user_training_courses.count <= 0
        sheet1[count_row, 11] = "未通过"
      end
      count_row += 1
    end

    book.write xls_report
    xls_report.string
  end
end
