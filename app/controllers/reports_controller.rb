class ReportsController < BaseController
	layout "reports"

  def index
  	@events_with_image = Event.where("picture_url_file_name IS NOT NULL").limit(5)
  	@bulletin = Event.where(classify: 1).order(created_at: :DESC).limit(5)
    @headline = Event.where(classify: 2).order(created_at: :DESC).limit(10)
    @activities = Event.where(classify: 3).order(created_at: :DESC).limit(6)
  end

  def show
  end

  def list
  	@events = Event.keyword(params[:keyword])
  	@bulletin = Event.where(classify: 1).order(created_at: :DESC).limit(5)
  end
end
