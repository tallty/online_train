# == Schema Information
#
# Table name: user_training_courses
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  state              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  remark             :string(255)
#  certificate_no     :string(255)
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

  # 统计报名学员的不同职位人数
  def self.role_count
    cache = User.includes(:user_training_courses).group(:role).count
    cache.map { |k, v| [User::ROLE[User.find_by_role(k).role.to_sym], v] }.to_h
  end

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:user).joins(:training_course).where(
      'users.name LIKE ?
       OR users.email LIKE ?
       OR users.address LIKE ?
       OR training_courses.name LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
