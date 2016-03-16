class AdminPanel::UserTasksController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_task, only: [:index, :download, :unsubmit_users]

  def index
  	@user_tasks = @task.user_tasks.keyword(params[:keyword]).page(params[:page]).per(15)
  end

  def list
  	@user_tasks = UserTask.all.keyword(params[:keyword]).page(params[:page]).per(15)
  end

  def show
  end

  #未提交作业的用户
  def unsubmit_users
    exclude_user_ids = @task.user_tasks.pluck(:user_id)
    training_course = TrainingCourse.find(params[:training_course_id])
    @user_training_courses = training_course.user_training_courses
                                            .where.not(id: exclude_user_ids)
                                            .page(params[:page]).per(15)
  end

  def download
    if @user_task.present?
      send_file @user_task.attachment.avatar.path,
        type: @user_task.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to admin_panel_task_user_tasks_path(@task)
    end
  end

  private
  def set_task
    @task = Task.find(params[:task_id])
  end
end
