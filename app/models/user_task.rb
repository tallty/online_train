# == Schema Information
#
# Table name: user_tasks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  title      :string(255)
#  content    :string(255)
#  appraise   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :admin_user_tasks
  has_one :attachment, as: :attachmentable

  validates :title, presence: true

  after_create do
    message = Message.create!(title: "作业已上传", content: "成功上传作业“#{self.task.try(:title)}”")
    UserMessage.create!(user_id: current_user.id, message_id: message.id)
  end

  after_update do
    message = Message.create!(title: "作业已更新", content: "成功更新作业“#{self.task.try(:title)}”")
    UserMessage.create!(user_id: current_user.id, message_id: message.id)
  end

  #评审结果
  def comment_result
    if self.admin_user_tasks.present? && self.admin_user_tasks.pluck(:score)[0].present?
      average = self.admin_user_tasks.first(2).collect(&:score).inject(:+) / 2
      if average < 60
        "不合格"
      else
        "合格"
      end
    else
      "暂无"
    end
  end

  #列出评阅老师名称
  def list_admin
    array = []
    admins = Admin.where({id: self.admin_user_tasks.pluck(:admin_id)})
    admins.each do |admin|
      array << admin.name
    end
    array.to_sentence
  end

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:user).where(
      'users.name LIKE ?
       OR user_tasks.title LIKE ?
       OR users.phone LIKE ?
       OR users.email LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
