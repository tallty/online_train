module AdminPanel::HomeHelper
	#登录日志
	def login_log admin
		admin.last_sign_in_at.strftime("%Y年%m月%d日 %H:%M").to_s + admin.name.to_s + '登录'
	end
end