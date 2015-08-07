class HomeController < BaseController
	def index
		#国培通知&报名
		@training_notifications = Notification.where(category: "国培通知").last(5)
		@training_courses = TrainingCourse.where(category: "国培通知").last(5)
		#骨干教师通知&报名
		@teacher_notifications = Notification.where(category: "骨干教师通知").last(5)
		@teacher_training_courses = TrainingCourse.where(category: "骨干教师通知").last(5)
		#专业负责人通知&报名
		@profession_notifications = Notification.where(category: "专业负责人通知").last(5)
		@profession_training_courses = TrainingCourse.where(category: "专业负责人通知").last(5)
	end
end