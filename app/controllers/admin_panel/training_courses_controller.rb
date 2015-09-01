module AdminPanel
	class TrainingCoursesController < AdminPanel::BaseController
		load_and_authorize_resource
		before_action :set_breadcrumb
		before_action :set_training_course, only: [:edit, :update, :show, :unchecked, :checked_by_expert, :checked_by_seminar, :checked_by_educator]

	  def index
			@search = TrainingCourse.search do
		    fulltext(params[:q]) do
		      fields(:name, :code, :category, :grade_leader, :be_applied)
		      #fields(:school_name)
		    end
		    all do
	        fulltext params[:be_applied], :fields => :be_applied
	      end
		  end
		end

		def list
			@search = TrainingCourse.search do
		    fulltext(params[:q]) do
		      fields(:name, :code, :category, :grade_leader, :be_applied)
		      fields(:school, :name)
		    end
		    all do
	        fulltext params[:be_applied], :fields => :be_applied
	      end
		  end
		end

		def show
		end

		def new
			@training_course = TrainingCourse.new
			add_breadcrumb "新建"
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
			@training_course.training_course_teachers << TrainingCourseTeacher.new(teacher_id: params[:training_course][:teacher_ids],
				                        training_course_id: @training_course.id)
			if @training_course.save
				flash[:notice] = "项目创建成功"
				return redirect_to admin_panel_training_courses_path
			else
				flash[:notice] = "项目创建失败"
				return redirect_to admin_panel_training_courses_path
			end
		end

		def edit
			add_breadcrumb "修改"
		end

		def update
			params[:training_course][:teacher_ids] ||= []
			if @training_course.update(training_course_params)
				flash[:notice] = "项目更新成功"
				return redirect_to admin_panel_training_courses_path
			else
				flash[:notice] = "项目更新失败"
				return redirect_to admin_panel_training_courses_path
			end
		end

		private

		def set_breadcrumb
			add_breadcrumb "后台", admin_panel_root_path
			add_breadcrumb "培训班级", admin_panel_training_courses_path
    end

		def set_training_course
			@training_course = TrainingCourse.find(params[:id])
		end

		def training_course_params
			params.require(:training_course).permit(:school_id, :name, :code, :start_time, :end_time,
			                       :plan_number, :training_agency, :training_address, :training_fee,
			                       :state, :remark, :info, :training_background, :training_target, :be_applied,
			                       :training_content, :check_method, :project_leader, :grade_leader, :contact, :category, {teacher_ids: []})
		end
	end
end