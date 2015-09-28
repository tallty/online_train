class AdminPanel::UserTasksController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_task, only: [:index, :show, :download]

  def index
  	@task = Task.find(params[:task_id])
  	@user_tasks = @task.user_tasks
  end

  def list
  	@user_tasks = UserTask.all
    add_breadcrumb "提交作业列表"
  end

  def show
  	add_breadcrumb "查看"
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
