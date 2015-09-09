class AdminPanel::JournalsController < AdminPanel::BaseController
  load_and_authorize_resource class: false

  def index
  	@journals = Journal.all
  end
end
