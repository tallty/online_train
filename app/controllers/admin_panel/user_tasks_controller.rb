class AdminPanel::UserTasksController < AdminPanel::BaseController
  load_and_authorize_resource

  def index
  end

  def list
  	@user_tasks = UserTask.all
  end
end
