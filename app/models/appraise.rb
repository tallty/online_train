# == Schema Information
#
# Table name: appraises
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  teacher_id         :integer
#  remark             :text(65535)
#  degree             :string(255)
#  training_course_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Appraise < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :training_course
  belongs_to :teacher

  #客观评价
	Degree = { '0' => '非常满意', '1' => '满意', '2' => '一般', '3' => '不满意', '4' => '非常不满意' }

	#搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:user).joins(:teacher).joins(:training_course).where(
      'users.name LIKE ?
       OR teachers.name LIKE ?
       OR training_courses.name LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
