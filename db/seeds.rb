# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#超级管理员
Admin.create(id: 1, email: "admin@buoyantec.com", name: 'buoyan', password: "12345678")

TrainingCourse.destory_all
TrainingCourse.create!([{
  name: "（国内）（上海）信息化教学 技术及信息化课程开发师资培训 （国培代码：09151005）",
  code: "09151005",
  start_time: "2015-08-04",
  end_time: "2015-08-28",
  plan_number: "50",
  grade_leader: "由寅君",
  training_agency: "上海电子信息技术职业学院",
  training_fee: 9000,
  state: "",
  remark: "",
  info: "",
  training_background: "",
  training_target: "",
  training_content: "",
  check_method: "",
  project_leader: "",
}])