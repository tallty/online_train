# == Schema Information
#
# Table name: user_training_courses
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  state              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class UserTrainingCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course

  after_create do
    message = Message.create!(title: "报名成功", content: "报名“#{self.training_course.try(:name)}”成功")
    UserMessage.create!(user_id: current_user.id, message_id: message.id)
  end

  #搜索功能
	searchable do
    text :user_name do
      user.name
    end
    text :user_email do
      user.email
    end
    text :user_phone do
      user.phone
    end
  end
end
