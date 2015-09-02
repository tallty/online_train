class Api::AdminsController < ActionController::Base
	def index
		@admins = Admin.where(role: 4)
		respond_to do |format|
			format.json {render json: @admins.to_json(only: [:name])}
		end
	end
end
