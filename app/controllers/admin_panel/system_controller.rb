module AdminPanel
	class SystemController < AdminPanel::ApplicationController
    load_and_authorize_resource
    
		def index
		end
	end
end