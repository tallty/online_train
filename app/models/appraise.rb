class Appraise < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :training_course
  belongs_to :teacher

  #客观评价
	Degree = { '0' => '非常不满意', '1' => '不满意', '2' => '一般', '3' => '满意', '4' => '非常满意' }
end
