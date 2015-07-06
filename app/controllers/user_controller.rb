class UserController < ApplicationController
  before_action :authenticate_user!
  
  def center
    @user = current_user
  end

  def course
  end

  def message1
  end
  def message2

  end

  def work
  end

  def journal
    
  end

  def update
    @user = User.where(id: params[:id]).first 

    #未查找到对应数据时处理
    if @user.blank?
      flash[:error] = "当前个人资料不存在"
      redirect_to user_index_path
    end

    if @user.update(user_params)

      #更新成功
      #重新登录更新session以及current_user等相关变量方法的值 
      sign_in(:user, @user)

      flash.now[:notice] = "个人资料更新成功"
      redirect_to center_user_index_path
    else
      #更新失败
      render :center
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,:ID_number, :nation, :gender, :birth, :school, :academy, :certificate,
                                  :position_name, :position, :address, :zip_code, :telephone, :phone,
                                  :qq_no, :summary, :country, :his_train)
    end

end
