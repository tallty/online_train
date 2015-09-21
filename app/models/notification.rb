class Notification < ActiveRecord::Base
	has_one :training_course
  default_scope { order("created_at DESC") }

	enum category: {
	  #country: '0',
	  teacher: '1',
	  manager: '2'
	}

	ListCategory = {
		#country: '国培培训',
	  teacher: '骨干教师培训',
	  manager: '专业负责人培训'
	}

	#搜索功能
	searchable do
    text :title
    text :sub_title
    text :category
    text :author
  end
end
