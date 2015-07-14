class AdminPanel::UserAppraiseTrainsController < AdminPanel::BaseController
  load_and_authorize_resource class: false
  
  def index
  end
end
