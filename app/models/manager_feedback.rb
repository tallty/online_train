class ManagerFeedback < ActiveRecord::Base
  belongs_to :admin, dependent: :destroy
  belongs_to :training_course, dependent: :destroy

  #搜索功能
	searchable do
    text :admin_name do
	    admin.name
	  end
	  text :training_course_name do
	    training_course.name
	  end
  end
end
