require 'rails_helper'

describe MessagesController do
  before do
    @user = create(:user)
    sign_in @user
  end

  after do
    sign_out @user
  end

  let!(:group) { create(:group, users: [@user]) }

  describe "GET #index" do
    it "renders the :index template" do
      get :index, params: { group_id: group }
      expect(response).to render_template :index
    end

    it "assigns an array of messages" do
      messages = create_list(:message, 3, user: @user, group: group)
      get :index, params: { group_id: group }
      expect(assigns(:messages)).to match(messages)
    end

    it "assigns an array of groups" do
      groups = create_list(:group, 3, users: [@user]) << group
      get :index, params: { group_id: group }
      expect(assigns(:groups)).to match(groups.sort { |a, b| a.id <=> b.id })
    end

    it "assigns the requested group to @group" do
      get :index, params: { group_id: group }
      expect(assigns(:group)).to eq group
    end
  end
end
