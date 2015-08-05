class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_one :attachment, as: :attachmentable

  validates :title, presence: true
end
