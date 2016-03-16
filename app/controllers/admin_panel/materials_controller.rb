class AdminPanel::MaterialsController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_material, only: [:show, :edit, :destroy, :download]

  def index
    @materials = Material.order_desc.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @material = Material.new
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
