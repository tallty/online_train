module AdminPanel
	class TrainingCoursesController < AdminPanel::BaseController
		load_and_authorize_resource
		before_action :set_notification, except: [:list, :list_by_school, :list_by_teacher, :detail]
		before_action :set_training_course, only: [:edit, :update, :show, :unchecked, :checked_by_expert, :checked_by_seminar, :checked_by_educator]
		before_action :set_grade_leader, only: [:new, :edit]

	  def index
			@training_courses = TrainingCourse.all.keyword(params[:keyword]).page(params[:page]).per(15)
		end

    #根据培训机构获取培训班列表
		def list_by_school
      @training_courses = TrainingCourse.where(school_id: current_admin.adminable_id).page(params[:page]).per(15)
		end

		#根据培训机构获取培训班列表
		def list_by_teacher
      @training_courses = TrainingCourse.where(admin_id: current_admin.id).page(params[:page]).per(15)
		end

		def list
			@training_courses = TrainingCourse.all.keyword(params[:keyword]).page(params[:page]).per(15)
		end

		def show
			respond_to do |format|
	      format.xls{
	        send_data( xls_content_for(@training_course),
	          :type => "text/excel;charset=utf-8; header=present",
	          :filename => "#{@training_course.name}(#{Time.now.strftime("%F %H%M%S")}).xls" )
	      }
	      format.html
	    end
		end

    #非管理员权限 查看
		def detail
		end

		def new
			@training_course = TrainingCourse.new
			@divide = @training_course.divides.build
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
			@divide = @training_course.divides.build
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

		def set_training_course
			@training_course = @notification.training_course
		end

		# 导出为xls
	  def xls_content_for(obj)
	    xls_report = StringIO.new
	    book = Spreadsheet::Workbook.new
	    sheet1 = book.create_worksheet :name => "培训班信息"

	    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
	    sheet1.row(0).default_format = blue

	    count_row = 1
	    sheet1.row(0).concat %w{作业 培训班 计划数 实际培训数 日志达标人数 作业提交人数}
      obj.tasks.each do |task|
	      sheet1[count_row, 0] = task.try(:attachment).try(:avatar_file_name)
	      sheet1[count_row, 1] = task.try(:training_course).try(:name)
	      sheet1[count_row, 2] = task.try(:training_course).plan_number
	      sheet1[count_row, 3] = task.try(:training_course).try(:user_training_courses).try(:length)
	      sheet1[count_row, 4] = task.try(:training_course).reached_journal_number.length
	      sheet1[count_row, 5] = task.submitted_count
	      count_row += 1
	    end

	    book.write xls_report
	    xls_report.string
	  end

		def training_course_params
			params.require(:training_course).permit(:journal_number, :task_end_time, :email, :phone, :linkman, :fax, :mobile,
				                     :admin_id, :start_apply_time, :end_apply_time, :notification_id, :school_id, :name, :code, :start_time, :end_time,
			                       :plan_number, :training_agency, :training_address, :training_fee,
			                       :state, :remark, :info, :training_background, :training_target, :be_applied,
			                       :training_content, :check_method, :project_leader, :grade_leader, :contact, :category, {teacher_ids: []},
			                       divides_attributes: [:id, :name, :header, :_destroy])
		end
	end
end