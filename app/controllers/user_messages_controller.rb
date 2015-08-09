class UserMessagesController < BaseController

  def destroy
    user_message = UserMessage.where(id: params[:id]).first
    user_message.destroy if user_message.present?
    redirect_to message_user_index_path
  end

  def read
    user_message = UserMessage.where(id: params[:id]).first 
    if user_message.present?
      user_message.status = true
      user_message.save
    end
    redirect_to message_user_index_path
  end
end
