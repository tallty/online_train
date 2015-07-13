class AdminPanel::AdminsController < AdminPanel::ApplicationController

  def index
  end

  def new
  end

  def create
  end

  def edit_profile
  end

  def edit_password
  end

  def update_password
    if params[:admin][:password].blank? || params[:admin][:password] != current_admin.password
      return render js: "$('#error-info').html('*原始密码不正确！');"
    end
    if params[:new_password].blank?
      return render js: "$('#error-info').html('*新密码不能为空！');"
    end
    if params[:confirm_new_password].blank? ||params[:confirm_new_password] != params[:new_password]
      return render js: "$('#error-info').html('*两次输入不一致！');"
    end
    if current_admin.update(password: params[:new_password])
      return render js: 'alert("密码更新成功！");window.location(history.go(0));'
    else
      return render js: 'alert("密码更新失败！");window.location(history.go(0));'
    end
  end


  def destroy
  end

end
