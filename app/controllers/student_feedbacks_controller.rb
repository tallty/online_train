class StudentFeedbacksController < BaseController
	before_action :authenticate_user!
	before_action :set_training_course
	before_action :set_student_feedback

	def new
		if @student_feedback.blank?
			@student_feedback = @training_course.student_feedbacks.new
			@student_feedback.user_id = current_user.id
			@student_feedback.save
		end
		return redirect_to edit_training_course_student_feedback_path(@training_course, @student_feedback)
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
		if @student_feedback.update(student_feedback_params.merge(user_id: current_user.id))
			return render js: 'alert("反馈信息创建成功!");window.location(history.go(0));'
		else
			return render js: 'alert("反馈信息创建失败!");window.location(history.go(0));'
		end
		respond_to do |format|
			format.js
		end
	end

	private
	def set_training_course
		@training_course = TrainingCourse.find(params[:training_course_id])
	end

	def set_student_feedback
		@student_feedback = StudentFeedback.where(training_course_id: @training_course.id, user_id: current_user.id).first
	end

	def student_feedback_params
		params.require(:student_feedback).permit(:user_id, :training_course_id, :teach, :discussion, :visiting, :organization,
			                                       :study_life, :most_value, :most_gain, :graduate_message)
	end
end
