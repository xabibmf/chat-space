class MessagesController < ApplicationController
  def index
    @groups = User.find(current_user.id).groups
    if params[:group_id]
      @group = Group.find(params[:group_id])
    else
      @group = @groups.first
    end
  end
end
