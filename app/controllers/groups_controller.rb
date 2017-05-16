class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def new
    respond_to do |format|
      format.html {
        @group = Group.new
        @group.users << current_user
      }
      format.json {
        render json: User.where("name like '%#{name_params[:name]}%'")
      }
    end
  end

  def index
    @groups = current_user.groups
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_messages_path(@group), notice: 'グループが作成されました。'
    else
      flash.now[:alert] = 'グループ作成に失敗しました。'
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループ情報が編集されました。'
    else
      flash.now[:alert] = 'グループ編集に失敗しました。'
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

  def name_params
    params.permit(:name)
  end
end
