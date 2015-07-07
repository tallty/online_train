module AdminPanel
	class SessionsController < ::Devise::SessionsController
		layout "admin_login"
	end
end