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

Task.destroy_all
Task.create!(id: 1, 
  title: "软件在信息化教学中的运用", 
  training_course_id: 1,
  admin_id: 1,
  body: "1.什么是虚拟化技术？谈谈你的认识。<br>2.请谈一下虚拟化技术在教育信息化中的应用。<br>3.什么是自由软件？相比较它有什么优势？<br>4.请谈一下教学课件的制作需要把握哪些原则。")
Task.create!(id: 2, 
  title: "信息化教学的教学模式与设计原则", 
  training_course_id: 1,
  admin_id: 1,
  body: "1. 围绕信息化教学的1-2个设计原则展开论述（运用系统方法指导教学设计；强调以“学习者”为中心；学习目标的多元化；问题或任务驱动；协作学习与个性化学习相结合 ；信息技术的支撑性 ；教学环境的开放性；评价的多元性、及时性）。
<br>要求： 字数在500字以上。<br>
2. 选择一堂课或一个知识点，重新进行教学设计。<br>
要求：（1）充分利用信息技术手段；（2）重点围绕“教学资源准备”“教学活动组织”两方面展开论述")

Task.create!(id: 3, 
  title: "大数据时代的职业教育信息化", 
  training_course_id: 1,
  admin_id: 1,
  body: "一、  什么是云计算？它的“前世今生”如何？云计算给您带来什么便利？<br>
二、  什么是大数据技术？日常生活和工作中您接触过哪些与大数据有关的技术？")