class NotificationsController < BaseController

	def index
		@all_notifications = Notification.all.page(params[:page]).per(15)
		@search_notifications = Notification.where(category: params[:category]).page(params[:page]).per(15)
	end

  def show
  	@notification = Notification.find(params[:id])
  	@notification.update(view_count: @notification.view_count + 1)
  end
end
