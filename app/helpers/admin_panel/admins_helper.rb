module AdminPanel::AdminsHelper

  def is_edit_or_update?
    params[:action] == "edit" || params[:action] == "update"
  end

  def admin_role_name role
    case role
    when "system"
      "管理部门"
    when "education"
      "教育部门"
    when "trainer"
      "培训机构"
    when "specialist"
      "评审专家"
    when "management"
      "班级负责人"
    end
  end

end
