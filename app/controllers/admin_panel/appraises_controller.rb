class AdminPanel::AppraisesController < AdminPanel::BaseController
	load_and_authorize_resource

	def list
		@appraises = Appraise.all
		add_breadcrumb "学员评师列表"
	end
end