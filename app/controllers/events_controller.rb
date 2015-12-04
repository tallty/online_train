class EventsController < BaseController
	layout "reports"
	def index
		@events = Event.all.page(params[:page]).per(20)
    @bulletin = Event.where(classify: 1).order(created_at: :DESC).limit(7)
    @headline = Event.where(classify: 2).order(created_at: :DESC).limit(5)
    @activities = Event.where(classify: 3).order(created_at: :DESC).limit(4)
	end

	def show
		@event = Event.find(params[:id])
	end

	private
	def event_params
			params.require(:event).permit(:title, :classify, :content, :picture_url)
	end

	def set_event
		@event = Event.find(params[:id])
	end
end 