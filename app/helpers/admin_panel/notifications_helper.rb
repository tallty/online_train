module AdminPanel::NotificationsHelper

	#判断notification是否对应创建了training_course
	def training_course_present?(notification_id)
		training_course = TrainingCourse.find_by(notification_id: notification_id)
		training_course.present?
	end

end