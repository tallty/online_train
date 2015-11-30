# == Schema Information
#
# Table name: student_feedbacks
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  training_course_id :integer
#  teach              :string(255)
#  discussion         :string(255)
#  visiting           :string(255)
#  organization       :string(255)
#  study_life         :string(255)
#  most_value         :text(65535)
#  most_gain          :text(65535)
#  graduate_message   :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

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
