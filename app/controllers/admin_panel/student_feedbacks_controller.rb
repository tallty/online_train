class AdminPanel::StudentFeedbacksController < AdminPanel::BaseController
	load_and_authorize_resource

	def list
		@student_feedbacks = StudentFeedback.all.keyword(params[:keyword])
		                                        .page(params[:page]).per(15)
		add_breadcrumb "学员反馈列表"
	end

	def show
		@student_feedback = StudentFeedback.find(params[:id])
		add_breadcrumb "查看"
	end
end
