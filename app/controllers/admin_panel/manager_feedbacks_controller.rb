class AdminPanel::ManagerFeedbacksController < AdminPanel::BaseController
	before_action :set_training_course, only: [:new, :edit, :update]
	before_action :set_manager_feedback, only: [:new, :edit, :update]
	def index
		@manager_feedbacks = ManagerFeedback.where(training_course_id: @training_course.id, admin_id: current_admin.id)
	end

	def list
		@manager_feedbacks = ManagerFeedback.keyword(params[:keyword])
		                                    .page(params[:page]).per(15)
	end

	def show
		@manager_feedback = ManagerFeedback.find(params[:id])
	end

	def new
		if @manager_feedback.blank?
			@manager_feedback = @training_course.build_manager_feedback
			@manager_feedback.save
		end
		return redirect_to edit_admin_panel_training_course_manager_feedback_path(@training_course, @manager_feedback)
	end

	def edit
	end

	def update
		if @manager_feedback.update(manager_feedback_params)
			flash[:notice] = "反馈信息创建成功"
			return redirect_to list_by_teacher_admin_panel_training_courses_path
		else
			flash[:notice] = "反馈信息创建失败"
			return redirect_to list_by_teacher_admin_panel_training_courses_path
		end
	end

	private
	def set_training_course
		@training_course = TrainingCourse.find(params[:training_course_id])
	end

	def set_manager_feedback
		@manager_feedback = @training_course.manager_feedback
	end

	def manager_feedback_params
		params.require(:manager_feedback).permit(:training_course_id, :admin_id, :organizer, :total_hours, :total_expenses,
		                                 :total_expenses_info, :feedback, :remark)
	end
end