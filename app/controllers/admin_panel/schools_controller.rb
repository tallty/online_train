class AdminPanel::SchoolsController < AdminPanel::BaseController
  load_and_authorize_resource
  
  def schools_by_province
    @schools = School.where(province_id: params[:province_id]).pluck(:name, :username)
    respond_to do |format|
      format.json { render json: @schools }
    end
  end
end
