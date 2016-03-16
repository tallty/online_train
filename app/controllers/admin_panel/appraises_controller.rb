class AdminPanel::AppraisesController < AdminPanel::BaseController
	load_and_authorize_resource

	def list
		@appraises = Appraise.all.keyword(params[:keyword]).page(params[:page]).per(15)
	end

	def show
		@appraises = Appraise.find(params[:id])
	end
end