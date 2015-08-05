class BaseController < ApplicationController
  before_action :set_current_user



  # 将当前用户传递到Model中
  def set_current_user
    User.current = current_user
  end

  
end
