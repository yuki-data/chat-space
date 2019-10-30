class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  def create
    Group.create(group_params)
    user_ids = params.require(:group)[:user_ids]
  end
  def edit
  end
  def update
  end
  def group_params
    params.require(:group).permit(:name)
  end
end
