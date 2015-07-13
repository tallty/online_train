module AdminPanel
  class ApplicationController < ActionController::Base
    # reset captcha code after each request for security
    #after_filter :reset_last_captcha_code!

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    layout "admin_panel"
    before_action :authenticate_admin!

    # 捕捉权限异常
    rescue_from CanCan::AccessDenied do |e|
      flash[:error] = I18n.t(:no_premission)
      redirect_to admin_panel_root_path
    end
  end
end