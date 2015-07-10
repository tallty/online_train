# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  title              :string(255)      not null
#  body               :text(65535)      not null
#  training_course_id :integer          not null
#  admin_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Task < ActiveRecord::Base
  belongs_to :training_courses
  belongs_to :admins
  has_one :attachment, as: :attachmentable
end
