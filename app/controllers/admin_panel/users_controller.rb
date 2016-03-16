class AdminPanel::UsersController < AdminPanel::BaseController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.page(params[:page]).per(20).keyword(params[:keyword])
  end

  def show
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if params[:user][:password].blank?
      return render js: "$('#errorAlert').html('密码不能为空');"
    end
    if params[:user][:password_confirmation].blank?
      return render js: "$('#errorAlert').html('密码不能为空');"
    end
    if params[:user][:password_confirmation] != params[:user][:password]
      return render js: "$('#errorAlert').html('两次输入不一致');"
    end
    @user.update(password: params[:user][:password_confirmation])
    flash[:notice] = "密码修改成功"
    return render js: "window.location.href = '#{session.delete(:return_to)}';"

    respond_to do |format|
      format.js
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
