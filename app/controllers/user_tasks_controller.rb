class UserTasksController < BaseController
  before_action :authenticate_user!
  before_action :set_user_task, only: [:edit, :update, :download]

  def new
    @user_task = UserTask.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @user_task = UserTask.new user_task_params

    if params[:user_task][:attachment]
      @user_task.attachment = Attachment.new if @user_task.attachment.blank?
      @user_task.attachment.avatar = params[:user_task][:attachment]
    end

    @user_task.user_id = current_user.id

    if @user_task.save
      @user_task.attachment.save(:validate => false)  if params[:user_task][:attachment]
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
    if params[:user_task][:attachment]
      @user_task.attachment = Attachment.new if @user_task.attachment.blank?
      @user_task.attachment.avatar = params[:user_task][:attachment]
    end

    if @user_task.update user_task_params
      @user_task.attachment.save(:validate => false)  if params[:user_task][:attachment]
    end
    respond_to do |format|
      format.js
    end
  end

  def download
    if @user_task.present?
      send_file @user_task.attachment.avatar.path,
        type: @user_task.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to work_user_index_path
    end
  end

  def show
    @task = Task.where(id: params[:id]).first
    respond_to do |format|
      format.js
    end
  end

  private
  def user_task_params
    params.require(:user_task).permit(:title, :content, :task_id)
  end

  def set_user_task
    @user_task = UserTask.where(id: params[:id]).first
  end
end
