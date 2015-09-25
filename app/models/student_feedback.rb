class StudentFeedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :training_course

  enum teach: {
	  t_much: '0',
	  t_less: '1',
	  t_suitable: '2'
	}
	enum discussion: {
	  d_much: '0',
	  d_less: '1',
	  d_suitable: '2'
	}
	enum visiting: {
	  v_much: '0',
	  v_less: '1',
	  v_suitable: '2'
	}

  #客观评价
	CommentContent = {
		1 => '太多',
	  2 => '太少',
	  3 => '适当'
	}

  Satisfaction = {
		1 => '满意',
	  2 => '尚可',
	  3 => '需改进'
	}

	D_CommentContent = {
	  d_much: '太多',
	  d_less: '太少',
	  d_suitable: '适当',
	}
	V_CommentContent = {
	  v_much: '太多',
	  v_less: '太少',
	  v_suitable: '适当'
	}

	enum organization: {
	  o_satisfaction: '0',
	  o_passable: '1',
	  o_improvement: '2'
	}
	enum study_life: {
	  s_satisfaction: '0',
	  s_passable: '1',
	  s_improvement: '2'
	}

  #满意度
	O_Satisfaction = {
		o_satisfaction: '满意',
	  o_passable: '尚可',
	  o_improvement: '需改进'
	}
	S_Satisfaction = {
	  s_satisfaction: '满意',
	  s_passable: '尚可',
	  s_improvement: '需改进'
	}
end
