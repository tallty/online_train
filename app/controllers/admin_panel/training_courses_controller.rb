module AdminPanel
	class TrainingCoursesController < AdminPanel::ApplicationController
		before_action :set_training_course, only: [:show]
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

		private

		def set_training_course
			@training_course = TrainingCourse.find(params[:id])
		end

		def training_course_params
			params.require(:training_course).permit(:name, :code, :start_time, :end_time,
			                       :plan_number, :training_agency, :training_address, :training_fee,
			                       :state, :remark, :info, :training_background, :training_target,
			                       :training_content, :check_method, :project_leader, :grade_leader, :contact)
		end
	end
end