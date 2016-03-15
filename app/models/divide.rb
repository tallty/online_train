class Divide < ActiveRecord::Base
  belongs_to :traing_course
  has_many :user_training_courses, dependent: :nullify  #关联的foreign key直接设置为空，避免删除关联对象
end
