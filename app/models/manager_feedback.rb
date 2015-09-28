class ManagerFeedback < ActiveRecord::Base
  belongs_to :admin, dependent: :destroy
  belongs_to :training_course, dependent: :destroy

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
