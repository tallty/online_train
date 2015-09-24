class CourseResource < ActiveRecord::Base
  belongs_to :training_course
  has_one :attachment, as: :attachmentable
end
