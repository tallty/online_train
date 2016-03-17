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
#  training_address    :string(255)
#  training_fee        :decimal(10, 2)
#  state               :string(255)
#  remark              :text(65535)
#  info                :text(65535)
#  training_background :text(65535)
#  training_target     :text(65535)
#  training_content    :text(65535)
#  check_method        :text(65535)
#  project_leader      :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contact             :string(255)
#  school_id           :integer
#  aasm_state          :string(255)
#  category            :string(255)
#  grade_leader        :string(255)
#  be_applied          :boolean          default(FALSE)
#  notification_id     :integer
#  start_apply_time    :datetime
#  end_apply_time      :datetime
#  admin_id            :integer
#  linkman             :string(255)
#  phone               :string(255)
#  fax                 :string(255)
#  mobile              :string(255)
#  email               :string(255)
#

class TrainingCourse < ActiveRecord::Base
	include AASM
  belongs_to :school
  belongs_to :admin
  belongs_to :notification
  has_many :tasks, dependent: :destroy
  has_many :user_training_courses, dependent: :destroy
  has_many :training_course_teachers, dependent: :destroy
  has_many :teachers, through: :training_course_teachers
  has_one :manager_feedback, dependent: :destroy
  has_many :student_feedbacks, dependent: :destroy
  has_many :course_resources, dependent: :destroy
  has_many :appraises, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :divides, dependent: :destroy
  has_many :users, through: :user_training_courses

  accepts_nested_attributes_for :divides,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true

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

  #日志达标
  def reached_journal_number
    journal_number = self.journal_number.to_i
    ids = self.user_training_courses.select{|x| x.user.journals.length >= journal_number}.map {|x| x.id}
    UserTrainingCourse.where({id: ids})
  end

  #日志不达标
  def unreached_journal_number
    journal_number = self.journal_number.to_i
    ids = self.user_training_courses.select{|x| x.user.journals.length < journal_number}.map {|x| x.id}
    UserTrainingCourse.where({id: ids})
  end

  # #作业提交人数
  # def submit_task_numbers
  #   task_ids = []
  #   self.tasks.each do |task|
  #     tasks = task.user_tasks
  #   end
  # end

  #个人中心添加日志时选取培训班列表
  def self.create_journal_list
    user_training_course_ids = UserTrainingCourse.where(user_id: current_user.id).pluck(:training_course_id)
    self.where({id: user_training_course_ids})
  end

  #剩余数量
  def remain_applied_number
  	if self.user_training_courses.where(state: false).count == 0
      (self.plan_number.to_i - self.user_training_courses.count) > 0 ? self.plan_number.to_i - self.user_training_courses.count : 0
    else
      (self.plan_number.to_i - self.user_training_courses.where(state: true).count - self.user_training_courses.where(state: nil).count) > 0 ? self.plan_number.to_i - self.user_training_courses.where(state: true).count - self.user_training_courses.where(state: nil).count : 0
    end
  end

  #提交作业截止前两天发布通知信息
  def self.generate_messages
    UserTrainingCourse.all.each do |user_training_course|
      now = Time.now.to_date
      end_time = (user_training_course.training_course.task_end_time - 2.days).to_date
      if now == end_time
        message = Message.create!(title: "提交作业提醒", content: "您报名的#{user_training_course.try(:training_course).try(:name)}课程，提交作业的截止时间是#{user_training_course.try(:training_course).try(:task_end_time).strftime('%Y-%m-%d')}")
        UserMessage.create!(user_id: user_training_course.user_id, message_id: message.id)
      end
    end
  end

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    joins(:school).where(
      'training_courses.name LIKE ?
       OR schools.name LIKE ?
       OR training_courses.code LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end

end
