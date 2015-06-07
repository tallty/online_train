module ApplicationHelper


  def all_school
    [
      ["上海电子信息职业技术学院","上海电子信息职业技术学院"],
      ["上海思博职业技术学院","上海思博职业技术学院"]
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
      user: {center: 5},
      "devise/sessions": {"new": 8},
      "devise/registrations": {"new": 7, create: 7},
    }
    menu[con_name][action_name] if menu.has_key?(con_name) and menu[con_name].has_key?(action_name)
  end

  def left_menu_index
    con_name = controller.controller_path.to_sym
    action_name = controller.action_name.to_sym
    menu = {
      project: {about: 0, background: 1},
      train: {notice_index: 2, notice_info: 2, apply_index: 3, apply_info: 3},
    }
    menu[con_name][action_name] if menu.has_key?(con_name) and menu[con_name].has_key?(action_name)
  end

  #个人中心左侧菜单栏选中
  def self_left_menu_index
    con_name = controller.controller_path.to_sym
    action_name = controller.action_name.to_sym
    menu = {
      user: {course: 0, work: 1, journal: 2, message: 3, center: 4},
    }
    menu[con_name][action_name] if menu.has_key?(con_name) and menu[con_name].has_key?(action_name)
  end
end
