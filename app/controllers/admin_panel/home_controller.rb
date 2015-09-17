module AdminPanel
	class HomeController < AdminPanel::BaseController
    load_and_authorize_resource  :class => false
		def index
			#即将开始的课程
      @training_courses = TrainingCourse.where("start_time > ?", Time.now)
      #当前管理用户的待办事件
      @todos = current_admin.todos.where(state: false)
      add_breadcrumb "管理后台"
		end
	end
end