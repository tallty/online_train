class AdminPanel::TasksController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_task, only: [:edit, :update, :destroy, :download, :show]

  def index
    @training_course = TrainingCourse.find(params[:training_course_id])
    @tasks = @training_course.tasks
                             .keyword(params[:keyword])
                             .page(params[:page]).per(15)
  end

  def list
    @tasks = Task.all.keyword(params[:keyword])
                     .page(params[:page]).per(10)
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
    session[:return_to] ||= request.referer
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

  def destroy
    @task.destroy
    redirect_to list_admin_panel_tasks_path
  end

  private

    def training_course_name
      training_course = TrainingCourse.find(params[:training_course_id])
      training_course.name
    end

    def task_params
       params.require(:task).permit(:title, :body, :training_course_id)
    end

    def set_task
      @task = Task.where(id: params[:id]).first
    end

end
