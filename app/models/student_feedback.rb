class StudentFeedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course

  #客观评价
	CommentContent = { '1' => '太多', '2' => '太少', '3' => '适当' }
  Satisfaction = { '1' => '满意', '2' => '尚可', '3' => '需改进' }

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:user).joins(:training_course).where(
      'users.name LIKE ?
      OR users.email LIKE ?
      OR users.phone LIKE ?
      OR training_courses.name LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
