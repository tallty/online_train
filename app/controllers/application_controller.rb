class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :email_confirmation, :password, :password_confirmation, :name,
                                                            :ID_number, :nation, :gender, :birth, :city, :school, :academy, :certificate,
                                                            :position_name, :position, :address, :zip_code, :telephone, :phone,
                                                            :qq_no, :summary, :captcha) }
  end

end