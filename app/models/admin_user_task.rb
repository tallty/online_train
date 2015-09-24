class AdminUserTask < ActiveRecord::Base
  belongs_to :admin
  belongs_to :user_task
  attr_accessor :admin_ids

  validates :score, presence: {message: '评审分数不能为空' }, on: :update
  validates :comment, presence: {message: '评审内容不能为空' }, on: :update

  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    eager_load(:user_task)
    .where("user_tasks.title like ?", "%#{keyword}%")
  end
end
