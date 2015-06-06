module ApplicationHelper


  def all_school
    [
      ["上海大学","上海大学"],
      ["复旦大学","复旦大学"],
      ["上海电子信息职业技术学院","上海电子信息职业技术学院"]
    ]
  end

  def all_academy
    [
      ["艺术设计系","艺术设计系"],
      ["计算机信息系","计算机信息系"],
      ["商务管理系","商务管理系"],
      ["应用外语系","应用外语系"]
    ]
  end


  #获取选中菜单链接index
  def get_menu_index
    con_name = controller.controller_path.to_sym
    action_name = controller.action_name.to_sym
    menu = {
      home: {index: 0},
      project: {about: 1, background: 2},
      train: {notice_index: 3, notice_info: 3, apply_index: 4, apply_info: 4},
      "devise/sessions": {"new": 8},
      "devise/registrations": {"new": 7, create: 7}
    }
    menu[con_name][action_name] if menu.has_key?(con_name) and menu[con_name].has_key?(action_name)
  end
end
