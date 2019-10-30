class GroupsController < ApplicationController
  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.create(group_params)
    if @group.errors.empty?
      user_ids = params.require(:group)[:user_ids]
      user_ids.each do |i|
        GroupUser.create(group_id: @group.id, user_id: i.to_i) unless i.empty?
      end

      redirect_to root_path, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    if @group.errors.empty?
      redirect_to root_path, notice: "グループを更新しました"
    else
      render :edit
    end
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
