class Journal < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course

  #统计journal数量
  def self.journal_amount(user_id, training_course_id)
    self.where(user_id: user_id, training_course_id: training_course_id).length
  end
end
