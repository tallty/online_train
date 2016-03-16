class AdminPanel::AdminsController < AdminPanel::BaseController
  before_action :set_admin, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    role = params[:role].present? ? params[:role] : "system"
    @admins = Admin.where(role: Admin.roles[role]).page(params[:page]).per(15)
  end

  #机构人员的new
  def new
    @admin = Admin.new
    respond_to do |format|
      format.js
    end
  end

  #机构人员的create
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

  #机构人员的edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  #机构人员的update
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

  #账户设置编辑个人信息
  def edit_profile
    @admin = current_admin
  end

  def update_profile
    @admin = current_admin
    if @admin.update(admin_params)
      flash[:notice] = "个人信息修改成功"
      return redirect_to edit_profile_admin_panel_admins_url
    else
      flash[:notice] = "个人信息修改失败"
      return redirect_to edit_profile_admin_panel_admins_url
    end
  end

  #账户设置编辑个人密码
  def edit_password
  end

  def update_password
    @admin = current_admin
    if @admin.update(admin_params)
      flash[:notice] = "个人密码修改成功"
      return redirect_to edit_password_admin_panel_admins_url
    else
      flash[:notice] = "个人密码修改失败"
      return redirect_to edit_password_admin_panel_admins_url
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
        :phone, :address, :agency, :school_id, :remark, :qq, :state, :postcode)
    end

    def set_admin
      @admin = Admin.where(id: params[:id]).first
      if @admin.blank?
        redirect_to admin_panel_admins_path(role: params[:role])
      end
    end

end
