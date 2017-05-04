class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]

  def index
    @groups = current_user.groups
    @messages = @group.messages.includes(:user)
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: "メッセージ送信成功"
    else
      redirect_to group_messages_path(@group), alert: "メッセージ送信失敗"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body).merge(params.permit(:group_id)).merge({user_id: current_user.id})
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
