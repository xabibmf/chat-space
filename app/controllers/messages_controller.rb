class MessagesController < ApplicationController
  def index
    @groups = User.find(current_user.id).groups
    @group = Group.find(params[:group_id])
  end
end
