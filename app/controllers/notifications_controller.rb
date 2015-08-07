class NotificationsController < BaseController

	def index
		@notifications = Notification.all.page(params[:page]).per(15)
	end

  def show
  	@notification = Notification.find(params[:id])
  	@notification.update(view_count: @notification.view_count + 1)
  end
end
