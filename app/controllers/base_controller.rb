class BaseController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user



  # 将当前用户传递到Model中
  def set_current_user
    User.current = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :email_confirmation, :password, :password_confirmation, :name,
                                                            :ID_number, :nation, :gender, :birth, :school, :academy, :certificate,
                                                            :position_name, :position, :address, :zip_code, :telephone, :phone,
                                                            :qq_no, :summary, :country) }
  end
end
