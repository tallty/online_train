# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



#超级管理员, 管理部门
Admin.destroy_all
Province.destroy_all

Admin.create!(id: 1, username: "shanghai", password: "123456", password_confirmation: "123456",
  role: 0, adminable_id: 1, adminable_type: "Province", province: "上海市",
  email: "shanghai@163.com", mobile: "021-88481688", phone: "18866668888")
Province.create!(id: 1, username: "shanghai", name: "上海市")