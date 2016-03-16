class AdminPanel::AdminUserTasksController < AdminPanel::BaseController
	load_and_authorize_resource
	before_action :set_user_task, only: [:new, :create]
	before_action :set_admin_user_task, only: [:edit, :update]

	def new
		@admin_user_task = @user_task.admin_user_tasks.new
		respond_to do |format|
      format.js
    end
	end

	def create
		@user_task.admin_user_tasks.destroy_all
		params[:admin_user_task][:admin_ids].each do |admin_id|
			if admin_id.present?
		  	AdminUserTask.create admin_user_task_params.merge(admin_id: admin_id, user_task_id: @user_task.id)
			end
		end
		flash[:notice] = "评审老师指派成功"
		redirect_to admin_panel_task_user_tasks_path(@user_task.task)
	end

	def edit
	end

	def update
		if @admin_user_task.update(admin_user_task_params)
			flash[:notice] = "评审创建成功"
			return redirect_to list_admin_panel_admin_user_tasks_path
		else
			flash[:notice] = "评审创建失败"
			return redirect_to list_admin_panel_admin_user_tasks_path
		end
	end

	def list
		@admin_user_tasks = AdminUserTask.where(admin_id: current_admin.id)
		                                 .page(params[:page]).per(15)
		                                 .keyword(params[:keyword])
	end

  private
  def admin_user_task_params
  	params.require(:admin_user_task).permit(:admin_id, :user_task_id, :score, :comment, {admin_ids: []})
  end

	def set_user_task
		@user_task = UserTask.find(params[:user_task_id])
	end

	def set_admin_user_task
		@admin_user_task = AdminUserTask.find(params[:id])
	end
end