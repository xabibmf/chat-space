class GroupsController < ApplicationController
  def new
    @group = Group.new
    @group.users << current_user
  end

  def index
    @groups = current_user.groups
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group), notice: 'グループが作成されました。'
    else
      redirect_to root_path, alert: 'グループ作成に失敗しました。'
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループ情報が編集されました。'
    else
      redirect_to root_path, alert: 'グループ編集に失敗しました。'
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
