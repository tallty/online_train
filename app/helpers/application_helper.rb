module ApplicationHelper


  def all_school
    [
      ["上海工程技术大学高职学院","上海工程技术大学高职学院"],
      ["上海应用技术学院高等职业学院","上海应用技术学院高等职业学院"],
      ["上海立信会计学院高职学院","上海立信会计学院高职学院"],
      ["上海第二工业大学高等职业技术学院","上海第二工业大学高等职业技术学院"],
      ["上海商学院高等技术学院","上海商学院高等技术学院"],
      ["上海健康医学院","上海健康医学院"],
      ["上海出版印刷高等专科学校","上海出版印刷高等专科学校"],
      ["上海旅游高等专科学校","上海旅游高等专科学校"],
      ["上海东海职业技术学院","上海东海职业技术学院"],
      ["上海行健职业学院","上海行健职业学院"],
      ["上海城建职业学院","上海城建职业学院"],
      ["上海城市管理职业技术学院","上海城市管理职业技术学院"],
      ["上海交通职业技术学院","上海交通职业技术学院"],
      ["上海海事职业技术学院","上海海事职业技术学院"],
      ["上海电子信息职业技术学院","上海电子信息职业技术学院"],
      ["上海济光职业技术学院","上海济光职业技术学院"],
      ["上海工商外国语职业学院","上海工商外国语职业学院"],
      ["上海科学技术职业学院","上海科学技术职业学院"],
      ["上海农林职业技术学院","上海农林职业技术学院"],
      ["上海建峰职业技术学院","上海建峰职业技术学院"],
      ["上海邦德职业技术学院","上海邦德职业技术学院"],
      ["上海中侨职业技术学院","上海中侨职业技术学院"],
      ["上海工艺美术职业学院","上海工艺美术职业学院"],
      ["上海震旦职业学院","上海震旦职业学院"],
      ["上海民远职业技术学院","上海民远职业技术学院"],
      ["上海欧华职业技术学院","上海欧华职业技术学院"],
      ["上海思博职业技术学院","上海思博职业技术学院"],
      ["上海立达职业技术学院","上海立达职业技术学院"],
      ["上海电影艺术职业学院","上海电影艺术职业学院"],
      ["上海工会管理职业学院","上海工会管理职业学院"],
      ["上海体育职业学院","上海体育职业学院"],
      ["上海民航职业技术学院","上海民航职业技术学院"],
      ["上海工商职业技术学院","上海工商职业技术学院"],
      ["上海公安高等专科学校","上海公安高等专科学校"]
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
      projects: {index: 1},
      notifications: {index: 2, show: 2},
      training_courses: {index: 3, show: 3},
      training_bases: {index: 4},
      user: {center: 5, course: 5, journal: 5, work: 5, message: 5, my: 5, update: 5},
      "devise/sessions": {"new": 8},
      "devise/registrations": {"new": 7, create: 7, edit: 5, update: 5},
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
      user: {course: 0, work: 1, journal: 2, message: 3, update: 4, my: 4},
      "devise/registrations":  {update: 4, edit: 4}
    }
    menu[con_name][action_name] if menu.has_key?(con_name) and menu[con_name].has_key?(action_name)
  end
end
