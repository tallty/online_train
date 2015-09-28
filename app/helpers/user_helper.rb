module UserHelper
	def ending_course_active
		if params[:controller] == "user" && params[:action] == "end_course"
			"active"
		elsif params[:controller] == "appraises" && params[:action] == "new"
			"active"
		elsif params[:controller] == "appraises" && params[:action] == "list"
			"active"
	  elsif ["journals", "student_feedbacks" ].include? params[:controller]
	  	"active"
		end
	end
end
