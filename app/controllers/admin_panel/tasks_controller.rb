class AdminPanel::TasksController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_task, only: [:edit, :update, :destroy, :download, :show]

  def index
    @tasks = Task.all
  end


  def new
    @task = Task.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @task = Task.new task_params

    if params[:task][:attachment]
      @task.attachment = Attachment.new if @task.attachment.blank?
      @task.attachment.avatar = params[:task][:attachment]
    end

    @task.admin_id = current_admin.id

    if @task.save
      @task.attachment.save(:validate => false)  if params[:task][:attachment]
    end

    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:task][:attachment]
      @task.attachment = Attachment.new if @task.attachment.blank?
      @task.attachment.avatar = params[:task][:attachment]
    end

    if @task.update task_params
      @task.attachment.save(:validate => false)  if params[:task][:attachment]
    end

    respond_to do |format|
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def download
    if @task.present?
      send_file @task.attachment.avatar.path,
        type: @task.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to admin_panel_tasks_path
    end
  end

  private
    def task_params
       params.require(:task).permit(:title, :body, :training_course_id)
    end

    def set_task
      @task = Task.where(id: params[:id]).first
    end

end
