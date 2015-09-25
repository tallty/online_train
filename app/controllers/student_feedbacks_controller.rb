class StudentFeedbacksController < BaseController
	before_action :set_training_course
	before_action :set_student_feedback, only: [:edit, :update]

	def new
		if @training_course.student_feedback.blank?
			@student_feedback = @training_course.build_student_feedback
			@student_feedback.user_id = current_user.id
			@student_feedback.save
		end
		return redirect_to edit_training_course_student_feedback_path(@training_course, @training_course.student_feedback)
	end

	def edit
	end

	def update
		if @student_feedback.update(student_feedback_params.merge(user_id: current_user.id))
			flash[:notice] = "反馈信息创建成功"
			return redirect_to edit_training_course_student_feedback_path(@training_course, @student_feedback)
		else
			flash[:notice] = "反馈信息创建失败"
			return redirect_to edit_training_course_student_feedback_path(@training_course, @student_feedback)
		end
	end

	private
	def set_training_course
		@training_course = TrainingCourse.find(params[:training_course_id])
	end

	def student_feedback_params
		params.require(:student_feedback).permit(:user_id, :training_course_id, :teach, :discussion, :visiting, :organization,
			                                       :study_life, :most_value, :most_gain, :graduate_message)
	end

	def set_student_feedback
		@student_feedback = StudentFeedback.find(params[:id])
	end
end
