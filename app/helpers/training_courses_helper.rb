module TrainingCoursesHelper
	def state_training_course training_course
		now = Time.now
		start_time = training_course.start_apply_time
	  end_time = training_course.end_apply_time
	  if now > start_time && now < end_time
	  	"进行中"
	  elsif now < start_time
	  	"未开始"
	  elsif now > end_time
	  	"已结束"
	  end
	end
end
