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
end
