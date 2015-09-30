module AdminPanel
	class TrainingCoursesController < AdminPanel::BaseController
		load_and_authorize_resource
		before_action :set_notification, except: [:list, :list_by_school, :list_by_teacher, :detail]
		before_action :set_breadcrumb, except: [:list, :list_by_school, :list_by_teacher]
		before_action :set_training_course, only: [:edit, :update, :show, :unchecked, :checked_by_expert, :checked_by_seminar, :checked_by_educator]
		before_action :set_grade_leader, only: [:new, :edit]

	  def index
			@search = TrainingCourse.all.keyword(params[:keyword]).page(params[:page]).per(15)
		end

    #根据培训机构获取培训班列表
		def list_by_school
      @training_courses = TrainingCourse.where(school_id: current_admin.adminable_id).page(params[:page]).per(15)
      add_breadcrumb "培训班列表"
		end

		#根据培训机构获取培训班列表
		def list_by_teacher
      @training_courses = TrainingCourse.where(admin_id: current_admin.id).page(params[:page]).per(15)
      add_breadcrumb "培训班列表"
		end

		def list
			@search = TrainingCourse.all.keyword(params[:keyword]).page(params[:page]).per(10)
		  add_breadcrumb "班级列表"
		end

		def show
			add_breadcrumb "查看"
		end

    #非管理员权限 查看
		def detail
			add_breadcrumb "查看"
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
			@training_course = TrainingCourse.new(training_course_params.merge(notification_id: @notification.id))
			@training_course.state = :unchecked
			@training_course.category = @notification.category
			@training_course.training_course_teachers << TrainingCourseTeacher.new(teacher_id: params[:training_course][:teacher_ids],
				                        training_course_id: @training_course.id)
			if @training_course.save
				flash[:notice] = "项目创建成功"
				return redirect_to admin_panel_notification_training_course_path(@notification, @training_course)
			else
				flash[:notice] = "项目创建失败"
				return redirect_to admin_panel_notification_training_course_path(@notification, @training_course)
			end
		end

		def edit
			add_breadcrumb "修改"
		end

		def update
			params[:training_course][:teacher_ids] ||= []
			if @training_course.update(training_course_params)
				flash[:notice] = "项目更新成功"
				return redirect_to admin_panel_notification_training_course_path(@notification, @training_course)
			else
				flash[:notice] = "项目更新失败"
				return redirect_to admin_panel_notification_training_course_path(@notification, @training_course)
			end
		end

		private

    #返回全部班级负责人
		def set_grade_leader
			@grade_leaders = Admin.where(role: 4)
		end

		def set_notification
			@notification = Notification.find(params[:notification_id])
		end

		def set_breadcrumb
			add_breadcrumb "培训班", admin_panel_training_courses_path
    end

		def set_training_course
			@training_course = @notification.training_course
		end

		def training_course_params
			params.require(:training_course).permit(:admin_id, :start_apply_time, :end_apply_time, :notification_id, :school_id, :name, :code, :start_time, :end_time,
			                       :plan_number, :training_agency, :training_address, :training_fee,
			                       :state, :remark, :info, :training_background, :training_target, :be_applied,
			                       :training_content, :check_method, :project_leader, :grade_leader, :contact, :category, {teacher_ids: []})
		end
	end
end