# == Schema Information
#
# Table name: training_courses
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  code                :string(255)
#  start_time          :datetime
#  end_time            :datetime
#  plan_number         :integer
#  grade_leader        :string(255)
#  training_agency     :string(255)
#  training_address    :string(255)
#  training_fee        :decimal(5, 2)
#  state               :string(255)
#  remark              :text(65535)
#  info                :string(255)
#  training_background :string(255)
#  training_target     :string(255)
#  training_content    :text(65535)
#  check_method        :text(65535)
#  project_leader      :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contact             :string(255)
#

class TrainingCourse < ActiveRecord::Base
	include AASM
  belongs_to :school, dependent: :destroy
  belongs_to :admin, dependent: :destroy
  belongs_to :notification, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :user_training_courses, dependent: :destroy
  has_many :training_course_teachers, dependent: :destroy
  has_many :teachers, through: :training_course_teachers
  has_one :manager_feedback, dependent: :destroy
  has_one :student_feedback, dependent: :destroy

  default_scope { order("created_at DESC") }

  #分类
  enum category: {
	  country: '0',
	  teacher: '1',
	  manager: '2'
	}

	ListCategory = {
		country: '国培培训',
	  teacher: '骨干教师培训',
	  manager: '专业负责人培训'
	}

  #状态机
	aasm :column => 'state' do
		state :unchecked, :initial => true  #默认未通过审核
		state :checked_by_expert     #通过专家审核
		state :checked_by_seminar    #通过研究会审核
		#state :checked_by_educator   #通过教委审核

    #暂定审核流程 专家审核 --》 研究会审核 --》 教委审核
		event :to_unchecked do
			transitions :from => [:checked_by_expert, :checked_by_seminar, :checked_by_educator], :to => :unchecked
		end

		event :to_checked_by_expert do
			transitions :from => :unchecked, :to => :checked_by_expert
		end

		event :to_checked_by_seminar do
			transitions :from => :checked_by_expert, :to => :checked_by_seminar
		end

		# event :to_checked_by_educator do
		# 	transitions :from => :checked_by_seminar, :to => :checked_by_educator
		# end
	end

  #后台首页统计报名人数
	def applied_users_count
		self.user_training_courses.where(state: true).count
	end

	#记录报名课程的3种状态
  def user_training_course_status
    case self.state
    when nil
      "审核中"
    when true
      "已通过"
    when false
      "未通过"
    end
  end

  #剩余数量
  def remain_applied_number
  	if self.user_training_courses.where(state: false).count == 0
      (self.plan_number.to_i - self.user_training_courses.count) > 0 ? self.plan_number.to_i - self.user_training_courses.count : 0
    else
      (self.plan_number.to_i - self.user_training_courses.where(state: true).count - self.user_training_courses.where(state: nil).count) > 0 ? self.plan_number.to_i - self.user_training_courses.where(state: true).count - self.user_training_courses.where(state: nil).count : 0
    end
  end

	#搜索功能
	searchable do
    text :name
    text :code
    text :category
    text :grade_leader
    text :be_applied
    # text :school_name do
    #   school.name
    # end
  end
end
