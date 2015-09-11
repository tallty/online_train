class AdminPanel::UserTasksController < AdminPanel::BaseController
  load_and_authorize_resource class: false

  def index
  end

  def list
  	@user_tasks = UserTask.all
  end
end
