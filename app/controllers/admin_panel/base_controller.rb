module AdminPanel
  class BaseController < ActionController::Base
    # reset captcha code after each request for security
    #after_filter :reset_last_captcha_code!

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    layout "admin_panel"
    before_action :authenticate_admin!, except: :download

    # 捕捉权限异常
    rescue_from CanCan::AccessDenied do |e|
      flash[:error] = I18n.t(:no_premission)
      redirect_to admin_panel_root_path
    end

    private
      # 将会将CanCan通过current_admin获取当前登录用户
      def current_ability
        @current_ability ||= Ability.new(current_admin)
      end
  end
end