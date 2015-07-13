# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#超级管理员, 管理部门
Admin.create(email: "admin@buoyantec.com", name: 'buoyan', password: "12345678", role: 0)

#教育部门管理员
Admin.create(email: "education@buoyantec.com", name: 'education', password: "12345678", role: 1)

#评审专家管理员
Admin.create(email: "expert@buoyantec.com", name: 'expert', password: "12345678", role: 3)

#培训机构管理员
Admin.create(email: "training@buoyantec.com", name: 'training', password: "12345678", role: 2)

#班级负责人
Admin.create(email: "grade@buoyantec.com", name: 'grade', password: "12345678", role: 4)

TrainingCourse.destroy_all
TrainingCourse.create!([{
  name: "（国内）（上海）信息化教学 技术及信息化课程开发师资培训 （国培代码：09151005）",
  code: "09151005",
  start_time: "2015-08-04",
  end_time: "2015-08-28",
  plan_number: "50",
  grade_leader: "由寅君",
  training_agency: "上海电子信息技术职业学院",
  state: "",
  remark: "",
  info: "",
  training_background: "",
  training_target: "",
  training_content: "",
  check_method: "",
  project_leader: "",
}])