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
    message = Message.create!(title: "已报名（待审核）", content: "报名“#{self.training_course.try(:name)}”成功")
    UserMessage.create!(user_id: current_user.id, message_id: message.id)
  end

  #记录报名课程的3种状态
  def user_training_course_status
    case self.state
    when nil
      "审核中"
    when true
      "已通过"
    when false
      "未通过"
    end
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

  #scope搜索方式
  scope :keyword_like, -> (keyword) do
    return all if keyword.blank?
    joins(:user).where(
      'users.name LIKE ?
       OR users.email LIKE ?
       OR users.address LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
