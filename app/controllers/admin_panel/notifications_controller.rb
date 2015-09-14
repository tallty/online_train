class AdminPanel::NotificationsController < AdminPanel::BaseController
  load_and_authorize_resource
  before_action :set_notification, only: [:show, :edit, :update]
  def index
    @search = Notification.search do
      fulltext(params[:q]) do
        fields(:title, :sub_title, :category)
      end
    end
    add_breadcrumb "通知列表", admin_panel_notifications_path
  end

  def new
  	@notification = Notification.new
    add_breadcrumb "新建通知"
  end

  def create
  	@notification = Notification.new(notification_params)
  	if @notification.save
  		flash[:notice] = "通知创建成功"
  		return redirect_to admin_panel_notifications_path
  	else
  		flash[:error] = "通知创建失败"
  		return render action: :new
  	end
  end

  def show
    add_breadcrumb "查看"
  end

  def edit
    add_breadcrumb "修改"
  end

  def update
  	if @notification.update(notification_params)
  		flash[:notice] = "通知修改成功"
  		return redirect_to admin_panel_notifications_path
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