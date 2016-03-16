class AdminPanel::TeachersController < AdminPanel::BaseController
  before_action :set_teacher, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  
  def index
    @teachers = Teacher.all.page(params[:page]).per(15)
  end

  def new
    @teacher = Teacher.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @teacher = Teacher.new teacher_params
    if @teacher.save
      respond_to do |format|
        flash[:notice] = "添加授课教师成功"
        format.js {render js: "location.href='#{admin_panel_teachers_path}'"}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @teacher.update teacher_params
      respond_to do |format|
        flash[:notice] = "更新授课教师信息成功"
        format.js {render js: "location.href='#{admin_panel_teachers_path}'"}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @teacher.destroy
    flash[:notice] = "授课教师删除成功"
    redirect_to admin_panel_teachers_path
  end


  private
    def teacher_params
       params.require(:teacher).permit(:name, :email, :mobile, :id_card, :position, :sex, :remark,
        :phone, :address, :school_id, :job_title, :qq)
    end

    def set_teacher
      @teacher = Teacher.where(id: params[:id]).first
      if @teacher.blank?
        redirect_to admin_panel_teachers_path
      end
    end
end
