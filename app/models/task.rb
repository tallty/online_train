# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  body               :text(65535)      not null
#  submit_user_count  :integer          default(0)
#  training_course_id :integer          not null
#  admin_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :training_course
  belongs_to :admin
  has_one :attachment, as: :attachmentable
  has_many :user_tasks, dependent: :destroy

  validates :title, presence: true
  validates :training_course_id, presence: true

  #已提交作业人数
  def submitted_count
    self.user_tasks.count
  end

  #未提交作业人数
  def unsubmitted_count
    #总报名数 - 提交作业数
  	self.training_course.user_training_courses.length - self.user_tasks.length
  end

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:admin).joins(:training_course).where(
      'admins.name LIKE ?
      OR training_courses.name LIKE ?
      OR tasks.title LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
