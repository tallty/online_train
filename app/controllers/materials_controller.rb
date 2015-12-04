class MaterialsController < ApplicationController
  layout "reports"
  def index
    @materials = Material.page(params[:page]).per(20)
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