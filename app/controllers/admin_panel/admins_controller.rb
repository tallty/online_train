class AdminPanel::AdminsController < AdminPanel::ApplicationController
  before_action :set_admin, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    role = params[:role].present? ? params[:role] : "system"
    @admins = Admin.where(role: Admin.roles[role])
  end

  def new
    @admin = Admin.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @admin = Admin.new admin_params

    #创建管理部门时创建省厅
    if @admin.system?
      province = Province.new
      province.username = params[:admin][:username]
      province.name = params[:admin][:province]
      @admin.adminable = province
    end

    #创建培训机构
    if @admin.trainer?
      school = School.new
      school.username = params[:admin][:username]
      school.name = params[:admin][:agency]
      school.province_id = params[:admin][:province]
      @admin.adminable = school
    end

    
    if @admin.save
      respond_to do |format|
        flash[:notice] = "添加用户成功"
        format.js {render js: "location.href='#{admin_panel_admins_path(role: @admin.role)}'"}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @admin = Admin.where(id: params[:id]).first
    respond_to do |format|
      format.js
    end
  end

  def update
    if @admin.update admin_params
      respond_to do |format|
        flash[:notice] = "更新用户成功"
        format.js {render js: "location.href='#{admin_panel_admins_path(role: @admin.role)}'"}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit_password
  end

  def update_password
    if params[:admin][:password].blank? || params[:admin][:password] != current_admin.password
      return render js: "$('#error-info').html('*原始密码不正确！');"
    end
    if params[:new_password].blank?
      return render js: "$('#error-info').html('*新密码不能为空！');"
    end
    if params[:confirm_new_password].blank? ||params[:confirm_new_password] != params[:new_password]
      return render js: "$('#error-info').html('*两次输入不一致！');"
    end
    if current_admin.update(password: params[:new_password])
      return render js: 'alert("密码更新成功！");window.location(history.go(0));'
    else
      return render js: 'alert("密码更新失败！");window.location(history.go(0));'
    end
  end


  def destroy
    #删除对应省厅
    if @admin.system?
      province = Province.where(id: @admin.adminable_id).first
      province.destroy if province.present?
    end
    #删除对应培训机构
    if @admin.trainer?
      school = School.where(id: @admin.adminable_id).first
      school.destroy if school.present?
    end
    
    @admin.destroy
    flash[:notice] = "删除成功"
    redirect_to admin_panel_admins_path(role: @admin.role)
  end

  private

    def admin_params
       params.require(:admin).permit(:username,:password, :password_confirmation, :role, :province, :name, :email, :mobile,
        :phone, :address, :agency, :school_id)
    end

    def set_admin
      @admin = Admin.where(id: params[:id]).first
      if @admin.blank?
        redirect_to admin_panel_admins_path(role: params[:role])
      end
    end

end
