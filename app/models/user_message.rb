# == Schema Information
#
# Table name: user_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message_id :integer
#  status     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  enum status: {unread: false, read: true}
  Status = {unread: '未读', read: '已读'}
end
