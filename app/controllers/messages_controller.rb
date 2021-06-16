class MessagesController < ApplicationController

  def index
    @related_users = current_user.related_users
  end

  def show
    @messages = Message.where(sender_id: [params[:id], params[:receiver_id]], receiver_id: [params[:id], params[:receiver_id]]).includes(:sender)
    receiver = User.find(params[:receiver_id])
    @option = [[receiver.name, receiver.id]]
    @new_message = current_user.active_messages.build
  end

  def new
    @message = current_user.active_messages.build
    @options = current_user.following.map { |following| [following.name, following.id] }
  end

  def create
    @message = current_user.active_messages.build(message_params)
    if @message.save
      flash[:success] = 'メッセージを送信しました。'
      redirect_to "/users/#{current_user.id}/#{message_params[:receiver_id]}/message"
      # redirect_to message_user_path(current_user, message_params[:receiver_id])
    else
      flash[:alert] = 'メッセージの送信に失敗しました。'
      render 'new'
    end
  end

  private
  def message_params
    params.require(:message).permit(:receiver_id, :content)
  end
end
