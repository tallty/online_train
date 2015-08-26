module AdminPanel
	class ActivitiesController < AdminPanel::BaseController
		load_and_authorize_resource

		def index
			@training_courses = TrainingCourse.all
		end

		def show
		end

		def new
			@training_course = TrainingCourse.new
		end

		def create
			@training_course = TrainingCourse.new(training_course_params)
			if @training_course.save
				flash[:notice] = "项目创建成功"
				return redirect_to admin_panel_training_courses_path
			else
				flash[:notice] = "项目创建失败"
				return redirect_to admin_panel_training_courses_path
			end
		end

		def edit
		end

	

		private

		def set_training_course
			@training_course = TrainingCourse.find(params[:id])
		end

	end
end