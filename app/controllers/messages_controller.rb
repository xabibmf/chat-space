class MessagesController < ApplicationController
  def index
    @groups = User.find(current_user.id).groups
  end
end
