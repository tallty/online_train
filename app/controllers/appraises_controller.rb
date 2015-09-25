class AppraisesController < BaseController
	before_action :set_training_course
	before_action :set_teachers

	def index
	end

	def new
		@appraise = Appraise.new
	end

	def create
		@teachers.each_with_index do |teacher, index|
			p = 'appraise_' + index.to_s
			@appraise = Appraise.new
			@appraise.degree = params[p.to_sym][:degree]
			@appraise.remark = params[p.to_sym][:remark]
			@appraise.save
		end
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
		@teachers = Teacher.where({id: @training_course.training_course_teachers.pluck(:teacher_id)})
	end
end