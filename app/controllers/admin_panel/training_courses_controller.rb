module AdminPanel
	class TrainingCoursesController < AdminPanel::BaseController
		load_and_authorize_resource

		before_action :set_training_course, only: [:show, :unchecked, :checked_by_expert, :checked_by_seminar, :checked_by_educator]
		def index
			@training_courses = TrainingCourse.all
		end

		def show
		end

		def new
			@training_course = TrainingCourse.new
		end

    #取消审核状态
		def unchecked
      @training_course.to_unchecked!
      redirect_to admin_panel_training_courses_path
		end

    #专家审核状态
		def checked_by_expert
			@training_course.to_checked_by_expert!
			redirect_to admin_panel_training_courses_path
		end

    #研究会审核状态
		def checked_by_seminar
			@training_course.to_checked_by_seminar!
			redirect_to admin_panel_training_courses_path
		end

    #教委审核状态
		def checked_by_educator
			@training_course.to_checked_by_educator!
			redirect_to admin_panel_training_courses_path
		end

		def create
			@training_course = TrainingCourse.new(training_course_params)
			@training_course.state = :unchecked
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