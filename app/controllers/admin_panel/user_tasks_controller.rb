class AdminPanel::UserTasksController < AdminPanel::BaseController
  load_and_authorize_resource

  def index
  	@task = Task.find(params[:task_id])
  	@user_tasks = @task.user_tasks
  end

  def list
  	@user_tasks = UserTask.all
    add_breadcrumb "提交作业列表"
  end

  def show
  	@user_task = UserTask.find(params[:id])
  	add_breadcrumb "查看"
  end
end
