class MessagesController < ApplicationController
  before_action :set_message, only: [:index, :create]

  def index
  end

  def create
    message = Message.create(message_params)
    if message.errors.empty?
      render :index
    else
      redirect_to group_messages_path(params[:group_id]), alert: "メッセージを入力してください"
    end
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(group_id: params[:group_id], user_id: current_user.id)
  end

  def set_message
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @messages = @group.messages.includes(:user)
    @message = Message.new
  end
end
