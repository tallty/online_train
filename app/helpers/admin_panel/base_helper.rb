module AdminPanel::BaseHelper

  #机构人员菜单显示
  #根据不同权限显示不同菜单，选中相应菜单
  #2015-97-11 fw
  def personnel_menu
  end

  #登录用户名现实
  #2015-97-13 fw
  def show_name
    return "" if current_admin.blank?
    if current_admin.system? || current_admin.trainer?
      current_admin.try(:adminable).try(:name) 
    else
      current_admin.name
    end
  end


  #页面中判断controller和action
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def divide_number divide
    "#{divide.name.to_s}[ #{UserTrainingCourse.where(divide_id: divide.id).length.to_s} ]"
  end

end
