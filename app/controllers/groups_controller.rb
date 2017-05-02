class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
    @groups = User.find(current_user.id).groups
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group), notice: 'グループが作成されました。'
    else
      redirect_to root_path, alert: 'グループ作成に失敗しました。'
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, {user_ids: []})
  end
end
