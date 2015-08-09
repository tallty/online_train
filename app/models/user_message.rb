class UserMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  enum status: {unread: false, read: true}
  Status = {unread: '未读', read: '已读'}
end
