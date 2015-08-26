class EventsController < BaseController
	layout "reports"
  	def index
  		@events = Event.all
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