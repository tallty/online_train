class AdminPanel::UserTasksController < AdminPanel::BaseController
  load_and_authorize_resource

  def index
  	@task = Task.find(params[:task_id])
  	@user_tasks = @task.user_tasks
  end

  def list
  	@user_tasks = UserTask.all
  end
end
