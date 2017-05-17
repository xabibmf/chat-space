class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def new
    @group = Group.new
    @group.users << current_user
    render :new_edit
  end

  def index
    @groups = current_user.groups
  end

  def edit
    render :new_edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group), notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループ情報が編集されました。'
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name).merge(params.permit(:user_ids => []))
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
