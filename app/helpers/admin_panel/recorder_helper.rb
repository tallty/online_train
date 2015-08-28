module AdminPanel::RecorderHelper
  #判断发布时间在两周内
  def event_in_two_weeks event
  	time = Time.now
  	time_two_week_ago = time - 2.weeks
  	time_two_week_ago < event.created_at &&  event.created_at < time
  end

end
