# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  has_many :user_messages, dependent: :destroy

  def message_by_user
    UserMessage.where(user_id: current_user.id, message_id: self.id).first
  end
end
