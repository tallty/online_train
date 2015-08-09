class UserMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  enum status: {unrend: false, read: true}
  Status = {unrend: '未读', read: '已读'}
end
