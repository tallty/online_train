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
  belongs_to :school
  has_one :notification
  has_many :tasks, dependent: :destroy

  enum training_course_categories: {
	  '国培通知': '0',
	  '骨干教师通知': '1',
	  '专业负责人通知': '2'
	}

	aasm :column => 'state' do
		state :unchecked, :initial => true  #默认未通过审核
		state :checked_by_expert     #通过专家审核
		state :checked_by_seminar    #通过研究会审核
		state :checked_by_educator   #通过教委审核

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

		event :to_checked_by_educator do
			transitions :from => :checked_by_seminar, :to => :checked_by_educator
		end
	end
end
