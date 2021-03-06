class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]
  before_action :set_messages, only: [:index, :create]

  def index
    @message = Message.new
    @reload_messages = @messages.search_new_messaage(reload_params[:messageId])
    if @reload_messages
      respond_to do |format|
        format.html
        format.json
      end
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html {
          redirect_to group_messages_path(@group), notice: "メッセージ送信成功"
        }
        format.json
      end
    else
      flash.now[:alert] = 'メッセージ送信失敗'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image).merge(params.permit(:group_id))
  end

  def reload_params
    params.permit(:messageId)
  end

  def set_group
    @groups = current_user.groups
    @group = @groups.find(params[:group_id])
  end

  def set_messages
    @messages = @group.messages.includes(:user)
  end
end
