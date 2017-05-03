class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @message = Message.new
  end

  def create
    @message = Message.create(body: message_params[:message][:body], group_id: message_params[:group_id], user_id: current_user.id)
  end

  private
  def message_params
    params.permit(:group_id, message: [:body])
  end
end
