class AdminPanel::AdminUserTasksController < AdminPanel::BaseController
	load_and_authorize_resource
	before_action :set_user_task
	def new
		@admin_user_task = @user_task.admin_user_tasks.new
	end

	def create
		@admin_user_task = AdminUserTask.new admin_user_task_params
		params[:admin_user_task][:admin_ids].each do |i|
			@admin_user_task = AdminUserTask.new(admin_id: i, user_task_id: @user_task.id) if i
			@admin_user_task.save
		end
		flash[:notice] = "评审专家指派成功"
		redirect_to admin_panel_task_user_tasks_path(@user_task.task)
	end

  private
  def admin_user_task_params
  	params.require(:admin_user_task).permit(:admin_id, :user_task_id, :score, :comment, {admin_ids: []})
  end
	def set_user_task
		@user_task = UserTask.find(params[:user_task_id])
	end
end