class CompetitionsController < BaseController
  layout "reports"
	def index
		@headlines = Event.headline.is_competition
		@bulletins = Event.bulletin.is_competition
	end
end
