class Api::MessagesController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    latest_message_id = params[:id].to_i
    @messages = group.messages.includes(:user).where("id > ?", latest_message_id)
  end
end
