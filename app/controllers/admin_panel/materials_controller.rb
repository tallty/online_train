class AdminPanel::MaterialsController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_material, only: [:show, :edit, :destroy, :download]
  before_action :set_breadcrumb

  def index
    @materials = Material.all.page(params[:page]).per(10)
    add_breadcrumb "培训资源列表"
  end

  def show
    add_breadcrumb "查看"
  end

  def new
    @material = Material.new
    add_breadcrumb "新建"
  end

  def create
    @material = Material.new(material_params)

    if params[:material][:attachment]
      @material.attachment = Attachment.new if @material.attachment.blank?
      @material.attachment.avatar = params[:material][:attachment]
    end

    if @material.save
      @material.attachment.save(:validate => false)  if params[:material][:attachment]
      flash[:notice] = "创建成功"
      return redirect_to admin_panel_materials_path
    else
      flash[:notice] = "创建失败"
      return redirect_to admin_panel_materials_path
    end
  end

  def edit
    add_breadcrumb "修改"
  end

  def destroy
    @material.destroy
    redirect_to admin_panel_materials_path
  end

  def update
    if params[:material][:attachment]
      @material.attachment = Attachment.new if @material.attachment.blank?
      @material.attachment.avatar = params[:material][:attachment]
    end

    if @material.update(material_params)
      @material.attachment.save(:validate => false)  if params[:material][:attachment]
      flash[:notice] = "更新成功"
      return redirect_to admin_panel_materials_path
    else
      flash[:notice] = "更新失败"
      return redirect_to admin_panel_materials_path
    end
  end

  def download
    if @material.present?
      send_file @material.attachment.avatar.path,
        type: @material.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to admin_panel_materials_path
    end
  end

  private
  def material_params
    params.require(:material).permit(:title, :catalog, :mdate)
  end

  def set_material
    @material = Material.find(params[:id])
  end

end
