class HomeController < BaseController
	def index
		#国培通知
		@training_notifications = Notification.where(category: "国培通知").last(5)
		#骨干教师通知
		@teacher_notifications = Notification.where(category: "骨干教师通知").last(5)
		#专业负责人通知
		@profession_notifications = Notification.where(category: "专业负责人通知").last(5)
	end
end