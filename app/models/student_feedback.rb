class StudentFeedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course

  #客观评价
	CommentContent = { '1' => '太多', '2' => '太少', '3' => '适当' }
  Satisfaction = { '1' => '满意', '2' => '尚可', '3' => '需改进' }
end
