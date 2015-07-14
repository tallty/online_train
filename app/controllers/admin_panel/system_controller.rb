module AdminPanel
	class SystemController < AdminPanel::BaseController
    load_and_authorize_resource class: false
    
		def index
		end
	end
end