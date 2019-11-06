class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.create(group_params)
    if @group.errors.empty?
      insert_group_users
      redirect_to root_path, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.update(group_params)
    if @group.errors.empty?
      @group.group_users.destroy_all
      insert_group_users
      redirect_to root_path, notice: "グループを更新しました"
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def insert_group_users
    user_ids = params.require(:group)[:user_ids]
    user_ids.each do |i|
      GroupUser.create(group_id: @group.id, user_id: i.to_i) unless i.empty?
    end
  end
end
