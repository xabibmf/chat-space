class UsersController < ApplicationController

  def search
    respond_to do |format|
      format.json {
        render "groups/new", json: User.where("name like '%#{name_params[:name]}%'")
      }
    end
  end

  private

  def name_params
    params.permit(:name)
  end
end
