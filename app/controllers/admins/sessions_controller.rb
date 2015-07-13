class Admins::SessionsController < Devise::SessionsController
  layout "admin_login"
  before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
     super
  end

  # protected
  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
  end

  #登录后跳转
  def after_sign_in_path_for(resource)
    admin_panel_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    #super(resource_or_scope)
    new_session_path(:admin)
  end
end
