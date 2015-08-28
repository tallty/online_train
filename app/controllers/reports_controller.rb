class ReportsController < BaseController
	layout "reports"

  def index
  	@events = Event.all
  	@bulletin = Event.where(classify: 1).order(created_at: :DESC).limit(5)
    @headline = Event.where(classify: 2).order(created_at: :DESC).limit(5)
    @activities = Event.where(classify: 3).order(created_at: :DESC).limit(4)
  end

  def show
  end

  def list
  	@events = Event.keyword(params[:keyword])
  end
end
