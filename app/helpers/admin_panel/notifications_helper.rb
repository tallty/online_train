module AdminPanel::NotificationsHelper

	#判断training_course是否对应创建了notification
	def notification_present?(training_course_id)
		notification = Notification.find_by(training_course_id: training_course_id)
		notification.present?
	end

end