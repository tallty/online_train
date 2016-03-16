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
  belongs_to :divide

  after_create do
    message = Message.create!(title: "已报名（待审核）", content: "报名“#{self.training_course.try(:name)}”成功")
    UserMessage.create!(user_id: current_user.id, message_id: message.id)
  end

  #记录报名课程的3种状态 -- 后台
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

  #记录报名课程的2种状态 -- 前台
  def user_training_course_on_going
    now = Time.zone.now
    end_time = self.training_course.end_time
    if now > end_time
      "已结业"
    else
      "未结业"
    end
  end

  scope :enabled, -> {
    where("user_training_courses.deleted_at is null")
  }

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

  scope :by_role, -> (role) {
    return all if role.blank?
    eager_load(:user).where("users.role = ?", User.roles[role])
  }

  scope :by_divide, -> (divide_id) {
    return all if divide_id.blank?
    where("user_training_courses.divide_id = ?", divide_id.to_i)
  }

  def self.get_user_training_course training_course, status
    return all if status.blank?
    reached_user_ids = []
    unreached_user_ids = []
    training_course.user_training_courses.each do |user_training_course|
      journals = Journal.where(training_course_id: training_course.id, user_id: user_training_course.user.id).length
      if journals >= training_course.journal_number.to_i
        reached_user_ids << user_training_course.user.id
      else
        unreached_user_ids << user_training_course.user.id
      end
    end
    if status == "reached"
      UserTrainingCourse.where({user_id: reached_user_ids})
    else
      UserTrainingCourse.where({user_id: unreached_user_ids})
    end
  end
end
