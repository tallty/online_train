class AdminPanel::TodosController < AdminPanel::BaseController
	load_and_authorize_resource

	def new
		@todo = current_admin.todos.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@todo = current_admin.todos.new(todo_params)
		if @todo.save
			flash[:notice] = "待办事项创建成功"
			return render js: "window.location.href = '#{admin_panel_root_url}';"
		else
			flash[:notice] = "待办事项创建失败"
			return render js: "window.location.href = '#{admin_panel_root_url}';"
		end
		respond_to do |format|
			format.js
		end
	end

	def edit
	end

	def update
		@todo = Todo.find(params[:id])
		if @todo.update(state: true)
			flash[:notice] = "待办事项状态置为已成功"
			return render js: "window.location.href = '#{admin_panel_root_url}';"
		else
			flash[:notice] = "待办事项重置失败"
			return render js: "window.location.href = '#{admin_panel_root_url}';"
		end
		respond_to do |format|
			format.js
		end
	end

	private
	def todo_params
		params.require(:todo).permit(:state, :content, :admin_id)
	end
end
