class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    group = Group.create(group_params)
    user_ids = params.require(:group)[:user_ids]
    user_ids.each do |i|
      GroupUser.create(group_id: group.id, user_id: i.to_i) unless i.empty?
    end
  end

  def edit
  end

  def update
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
