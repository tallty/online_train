class AdminPanel::NotificationsController < AdminPanel::BaseController
  #load_and_authorize_resource class: false
  before_action :set_training_course
  before_action :set_notification, only: [:show, :edit, :update]

  def new
  	@notification = @training_course.build_notification
  end

  def create
  	@notification = Notification.new(notification_params.merge(training_course_id: @training_course.id, category: @training_course.category))
  	if @notification.save
  		flash[:notice] = "通知创建成功"
  		return redirect_to admin_panel_training_course_notification_path(@training_course, @notification)
  	else
  		flash[:error] = "通知创建失败"
  		return render action: :new
  	end
  end

  def show
  end

  def edit
  end

  def update
  	if @training_course.notification.update(notification_params.merge(training_course_id: @training_course.id))
  		flash[:notice] = "通知修改成功"
  		return redirect_to admin_panel_training_course_notification_path(@training_course, @notification)
  	else
  		flash[:error] = "通知修改失败"
  		return render action: :edit
  	end
  end

  private

  def set_training_course
  	@training_course = TrainingCourse.find(params[:training_course_id])
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
  	params.require(:notification).permit(:training_course_id, :title, :sub_title, :view_count, :author, :content, :category)
  end
end