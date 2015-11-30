# == Schema Information
#
# Table name: course_resources
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  remark             :text(65535)
#  training_course_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class CourseResource < ActiveRecord::Base
  belongs_to :training_course
  has_one :attachment, as: :attachmentable
end
