class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]

  def index
    @groups = current_user.groups
    @messages = @group.messages.includes(:user)
    @message = Message.new
  end

  def create
    @message = Message.new(body: message_params[:message][:body], group_id: message_params[:group_id], user_id: current_user.id)
    if @message.save
      redirect_to group_messages_path(@group)
    else
      redirect_to group_messages_path(@group), alert: "メッセージ送信失敗"
    end
  end

  private

  def message_params
    params.permit(:group_id, message: [:body])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
