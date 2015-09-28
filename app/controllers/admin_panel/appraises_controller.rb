class AdminPanel::AppraisesController < AdminPanel::BaseController
	load_and_authorize_resource

	def list
		@appraises = Appraise.all.keyword(params[:keyword]).page(params[:page]).per(15)
		add_breadcrumb "学员评师列表"
	end

	def show
		@appraises = Appraise.find(params[:id])
		add_breadcrumb "查看"
	end
end