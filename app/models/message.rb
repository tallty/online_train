class Message < ActiveRecord::Base
  has_many :user_messages, dependent: :destroy

  def message_by_user
    UserMessage.where(user_id: current_user.id, message_id: self.id).first
  end
end
