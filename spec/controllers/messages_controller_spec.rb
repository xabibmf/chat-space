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

  describe "POST #create" do
    let(:message_params) do
      {
        group_id: group,
        message: {
          body: "test message"
        }
      }
    end
    let(:message_empty) do
      {
        group_id: group,
        message: {
          body: ""
        }
      }
    end

    it "saves the new message in the database" do
      expect { post :create, params: message_params }.to change(Message, :count).by(1)
    end

    it "not saves the new message when body empty" do
      expect { post :create, params: message_empty }.to change(Message, :count).by(0)
    end

    it "redirect to group_messages_path when successing create message" do
      post :create, params: message_params
      expect(response).to redirect_to group_messages_path
    end

    it "renders the :index when failing create message" do
      post :create, params: message_empty
      expect(response).to render_template :index
    end
  end
end
