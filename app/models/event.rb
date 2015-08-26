class Event < ActiveRecord::Base
	has_attached_file :picture_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/lunbo.png"
  	validates_attachment_content_type :picture_url, content_type: /\Aimage\/.*\Z/
  	enum classify: {bulletin: 1, headline: 2, activity: 3}
  	EventClassify = {bulletin: '通知公告', headline: '要闻', activity: '活动简报'}
end
