class AdminPanel::StudentFeedbacksController < AdminPanel::BaseController
	load_and_authorize_resource

	def list
		@student_feedbacks = StudentFeedback.all
		add_breadcrumb "学员反馈列表"
	end
end