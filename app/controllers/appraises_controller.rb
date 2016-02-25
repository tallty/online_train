class AppraisesController < BaseController
	before_action :authenticate_user!
	before_action :set_training_course
	before_action :set_teachers

	def index
	end

	def new
		@appraise = Appraise.new
	end

	def create
		@teacher_ids.each_with_index do |teacher, index|
			p = 'appraise_' + index.to_s
			@appraise = Appraise.new
			@appraise.user_id = current_user.id
			@appraise.teacher_id = teacher.id
			@appraise.training_course_id = @training_course.id
			@appraise.degree = params[p.to_sym][:degree]
			@appraise.remark = params[p.to_sym][:remark]
			@appraise.save
		end
		return render js: "alert('学员评价创建成功!'); window.location.href = '#{list_training_course_appraises_path(@training_course)}';"
		respond_to do |format|
			format.js
		end
	end

	def list
		@appraises = Appraise.where(training_course_id: @training_course.id, user_id: current_user.id)
	end

	def edit
	end

	def update
	end


	private
	def set_training_course
		@training_course = TrainingCourse.find(params[:training_course_id])
	end

	def set_teachers
		@teacher_ids = Teacher.where({id: @training_course.training_course_teachers.pluck(:teacher_id)})
	end
end