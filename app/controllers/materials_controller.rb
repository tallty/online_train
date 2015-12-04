class MaterialsController < ApplicationController
  layout "reports"
  def index
    @materials = Material.is_materials
                         .page(params[:page])
                         .per(20)
  end

  #专业人才培养方案列表
  def list
    if params[:date].present?
      @materials = Material.is_professional
                         .where(mdate: params[:date])
                         .page(params[:page])
                         .per(20)
    else
      @materials = Material.is_professional
                         .page(params[:page])
                         .per(20)
    end
    @material_dates = Material.group(:mdate)
  end

  def download
    @material = Material.find(params[:id])
    if @material.present?
      send_file @material.attachment.avatar.path,
        type: @material.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to admin_panel_materials_path
    end
  end
end