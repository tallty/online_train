class AdminPanel::TeachersController < AdminPanel::BaseController
  load_and_authorize_resource
  
  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
    respond_to do |format|
      format.js
    end
  end
end
