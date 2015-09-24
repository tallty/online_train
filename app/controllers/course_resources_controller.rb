class CourseResourcesController < BaseController
  before_action :set_training_course
	def index
    @course_resources = @training_course.course_resources
    respond_to do |format|
      format.js
      format.html
    end
	end

  def download
    @course_resource = @training_course.course_resources.find(params[:id])
    if @course_resource.present?
      send_file @course_resource.attachment.avatar.path,
        type: @course_resource.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to user_course_index_path
    end
  end

  private
  def set_training_course
    @training_course = TrainingCourse.find(params[:training_course_id])
  end
end