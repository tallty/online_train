class Notification < ActiveRecord::Base
	belongs_to :training_course
  default_scope { order("created_at DESC") }

	enum category: {
	  country: '0',
	  teacher: '1',
	  manager: '2'
	}

	ListCategory = {
		country: '国培培训',
	  teacher: '骨干教师培训',
	  manager: '专业负责人培训'
	}
end
