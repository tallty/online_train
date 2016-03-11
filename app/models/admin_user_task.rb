# == Schema Information
#
# Table name: admin_user_tasks
#
#  id           :integer          not null, primary key
#  admin_id     :integer
#  user_task_id :integer
#  score        :decimal(5, 2)
#  comment      :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AdminUserTask < ActiveRecord::Base
  belongs_to :admin
  belongs_to :user_task
  attr_accessor :admin_ids

  validates :score, presence: {message: '评审分数不能为空' }, on: :update
  validates :comment, presence: {message: '评审内容不能为空' }, on: :update

  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    eager_load(:user_task).where("user_tasks.title like ?", "%#{keyword}%")
  end
end
