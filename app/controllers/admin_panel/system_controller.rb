module AdminPanel
	class SystemController < AdminPanel::BaseController
    load_and_authorize_resource
    
		def index
		end
	end
end