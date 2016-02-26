module TrainingCoursesHelper
# 	def state_training_course training_course
# 		now = Time.new
# 		start_time = training_course.start_apply_time
# 	  end_time = training_course.end_apply_time
# 	  if now > start_time && now < end_time
# 	  	content_tag(:a, "进行中", class: "btn btn-success", href: new_user_session_path)
# 	  elsif now < start_time
# 	  	content_tag(:a, "未开始", class: "btn btn-default", href: "javascript:void(0)")
# 	  elsif now > end_time
# 	   	content_tag(:a, "已结束", class: "btn btn-default", href: "javascript:void(0)")
# 	  # elsif !training_course.be_applied
# 	  # 	content_tag(:a, "暂时不能报名", class: "btn btn-danger", href: "javascript:void(0)")
# 	  # else
# 	  # 	content_tag(:a, "请先登录", class: "btn btn-lg btn-primary apply-btn", href: new_user_session_path)
# 	  end
# 	end

  def print_info info
    info.present? ? info : content_tag(:div, "请完善相关信息!", class: "text-danger")
  end
end