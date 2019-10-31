class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @message = Message.new
  end

  def create
    Message.create(message_params)
  end

  def message_params
    params.require(:message).permit(:content).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
