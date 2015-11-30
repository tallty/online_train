class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  #after_filter :reset_last_captcha_code!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  after_filter :store_location



  # 将当前用户传递到Model中
  def set_current_user
    User.current = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :email_confirmation, :password, :password_confirmation, :name,
                                                            :ID_number, :nation, :gender, :birth, :school, :academy, :profession, :certificate,
                                                            :position_name, :position, :address, :zip_code, :telephone, :phone,
                                                            :qq_no, :summary, :country, :role, :his_train) }
  end

  private
  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  #登陆后跳转页面
  def after_sign_in_path_for(resource)
    session[:previous_url] || home_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_url] || home_index_path
  end

end