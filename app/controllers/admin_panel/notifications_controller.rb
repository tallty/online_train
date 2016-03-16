class AdminPanel::NotificationsController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_notification, only: [:show, :edit, :update]
  def index
    @notifications = Notification.keyword(params[:keyword])
                                 .page(params[:page]).per(15)
  end

  def new
  	@notification = Notification.new
  end

  def create
  	@notification = Notification.new(notification_params)

    if params[:notification][:attachment]
      @notification.attachment = Attachment.new if @notification.attachment.blank?
      @notification.attachment.avatar = params[:notification][:attachment]
    end

  	if @notification.save
      @notification.attachment.save(:validate => false)  if params[:notification][:attachment]
  		flash[:notice] = "通知创建成功"
  		return redirect_to admin_panel_notifications_path
  	else
  		flash[:error] = "通知创建失败"
  		return render action: :new
  	end
  end

  def show
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if params[:notification][:attachment]
      @notification.attachment = Attachment.new if @notification.attachment.blank?
      @notification.attachment.avatar = params[:notification][:attachment]
    end

  	if @notification.update(notification_params)
      @notification.attachment.save(:validate => false)  if params[:notification][:attachment]
  		flash[:notice] = "通知修改成功"
  		return redirect_to session.delete(:return_to)
  	else
  		flash[:error] = "通知修改失败"
  		return render action: :edit
  	end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
  	params.require(:notification).permit(:title, :sub_title, :view_count, :author, :content, :category)
  end
end