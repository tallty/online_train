class CompetitionsController < BaseController
	def index
		@headlines = Event.headline.is_competition
		@bulletins = Event.bulletin.is_competition
	end
end
