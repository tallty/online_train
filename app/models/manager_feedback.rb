# == Schema Information
#
# Table name: manager_feedbacks
#
#  id                  :integer          not null, primary key
#  admin_id            :integer
#  training_course_id  :integer
#  organizer           :string(255)
#  total_hours         :string(255)
#  total_expenses      :string(255)
#  total_expenses_info :text(65535)
#  feedback            :text(65535)
#  remark              :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ManagerFeedback < ActiveRecord::Base
  belongs_to :admin
  belongs_to :training_course

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:admin).joins(:training_course).where(
      'admins.name LIKE ?
      OR manager_feedbacks.organizer LIKE ?
      OR training_courses.name LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
