class Appraise < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  belongs_to :training_course

  enum degree: {
	  degree_0: '0',
	  degree_1: '1',
	  degree_2: '2',
	  degree_3: '3',
	  degree_4: '4',
	}

  #客观评价
	Degree = {
		0: '非常不满意',
	  1: '不满意',
	  2: '一般',
	  3: '满意',
	  4: '非常满意'
	}
end
