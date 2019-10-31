class MessagesController < ApplicationController
  before_action :set_message, only: [:index, :create]

  def index
  end

  def create
    message = Message.create(message_params)
    render :index if message.errors.empty?
  end

  def message_params
    params.require(:message).permit(:content).merge(group_id: params[:group_id], user_id: current_user.id)
  end

  def set_message
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @message = Message.new
  end
end
