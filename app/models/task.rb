# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  body               :text(65535)      not null
#  submit_user_count  :integer          default(0)
#  training_course_id :integer          not null
#  admin_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :training_course
  belongs_to :admin
  has_one :attachment, as: :attachmentable
  has_many :user_tasks, dependent: :destroy
  
  validates :title, presence: true
  validates :training_course_id, presence: true
end
