class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  #after_filter :reset_last_captcha_code!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user



  # 将当前用户传递到Model中
  def set_current_user
    User.current = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :email_confirmation, :password, :password_confirmation, :name,
                                                            :ID_number, :nation, :gender, :birth, :school, :academy, :profession, :certificate,
                                                            :position_name, :position, :address, :zip_code, :telephone, :phone,
                                                            :qq_no, :summary, :country) }
  end

  private
  #登陆后跳转页面
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || home_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    home_index_path
  end

end