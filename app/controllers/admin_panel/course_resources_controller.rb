class AdminPanel::CourseResourcesController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_training_course
  before_action :set_course_resource, only: [:edit, :update, :destroy, :download]

  def index
  	@course_resources = @training_course.course_resources.page(params[:page]).per(15)
  end

  def new
    @course_resource = CourseResource.new
  end

  def create
    @course_resource = @training_course.course_resources.new(course_resource_params)

    if params[:course_resource][:attachment]
      @course_resource.attachment = Attachment.new if @course_resource.attachment.blank?
      @course_resource.attachment.avatar = params[:course_resource][:attachment]
    end

    if @course_resource.save
      @course_resource.attachment.save(:validate => false)  if params[:course_resource][:attachment]
      flash[:notice] = "课程附件创建成功"
      return redirect_to admin_panel_training_course_course_resources_path(@training_course)
    else
      flash[:notice] = "课程附件创建失败"
      return redirect_to admin_panel_training_course_course_resources_path(@training_course)
    end
  end

  def edit
  end

  def update
    if params[:course_resource][:attachment]
      @course_resource.attachment = Attachment.new if @course_resource.attachment.blank?
      @course_resource.attachment.avatar = params[:course_resource][:attachment]
    end

    if @course_resource.update(course_resource_params)
      @course_resource.attachment.save(:validate => false)  if params[:course_resource][:attachment]
      flash[:notice] = "课程附件更新成功"
      return redirect_to admin_panel_training_course_course_resources_path(@training_course)
    else
      flash[:notice] = "课程附件更新失败"
      return redirect_to admin_panel_training_course_course_resources_path(@training_course)
    end
  end

  def destroy
    @course_resource.destroy && @course_resource.attachment.destroy
    return redirect_to admin_panel_training_course_course_resources_path(@training_course)
  end

  def download
    if @course_resource.present?
      send_file @course_resource.attachment.avatar.path,
        type: @course_resource.attachment.avatar.content_type,
        x_sendfile: true
    else
      redirect_to admin_panel_training_course_course_resources_path(@training_course)
    end
  end

  private
  def set_training_course
    @training_course = TrainingCourse.find(params[:training_course_id])
  end

  def set_course_resource
    @course_resource = @training_course.course_resources.find(params[:id])
  end

  def course_resource_params
    params.require(:course_resource).permit(:title, :remark, :training_course_id)
  end
end