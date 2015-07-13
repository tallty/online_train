module AdminPanel::ApplicationHelper

  #机构人员菜单显示
  #根据不同权限显示不同菜单，选中相应菜单
  #2015-97-11 fw
  def personnel_menu
  end

  #页面中判断controller和action
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

end
