# == Schema Information
#
# Table name: journals
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  title              :string(255)
#  content            :text(65535)
#  add_date           :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Journal < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course

  validates :add_date, presence: true
  validates :content, presence: true

  #统计journal数量
  def self.journal_amount(user_id, training_course_id)
    self.where(user_id: user_id, training_course_id: training_course_id).length
  end

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:user).joins(:training_course).where(
      'users.name LIKE ?
      OR training_courses.name LIKE ?
      OR journals.content LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
