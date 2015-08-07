class Notification < ActiveRecord::Base
	belongs_to :training_course
  default_scope { order("created_at DESC") }

	enum notification_categories: {
	  '国培通知': '0',
	  '骨干教师通知': '1',
	  '专业负责人通知': '2'
	}
end
