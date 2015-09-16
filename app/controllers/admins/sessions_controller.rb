class Admins::SessionsController < Devise::SessionsController
  layout "admin_login"
  before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    # if user_signed_in?
    #   flash[:notice] = "你已经登录"
    #   return redirect_to root_path
    # end
    self.resource = warden.authenticate({scope: :admin})
    if self.resource.present?
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash[:notice] = "邮箱或密码错误"
      if params[:role].empty?
        redirect_to new_session_path(:admin)
      else
        redirect_to new_session_path(:admin, role: params[:role])
      end
    end
    #super
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
