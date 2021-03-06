require 'rails_helper'

describe MessagesController do
  before do
    @user = create(:user)
    sign_in @user
  end

  after do
    sign_out @user
  end

  let(:group) { create(:group, users: [@user]) }

  describe "GET #index" do
    it "renders the :index template" do
      get :index, params: { group_id: group }
      expect(response).to render_template :index
    end

    it "assigns an array of messages" do
      messages = create_list(:message, 3, user: @user, group: group)
      get :index, params: { group_id: group }
      expect(assigns(:messages)).to match_array(messages)
    end

    it "assigns an array of groups" do
      groups = create_list(:group, 3, users: [@user])
      get :index, params: { group_id: groups[0] }
      expect(assigns(:groups)).to match_array(groups)
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

    context "when message body exist" do
      it "saves the new message in the database" do
        expect { post :create, params: message_params }.to change(Message, :count).by(1)
      end

      it "redirect to group_messages_path" do
        post :create, params: message_params
        expect(response).to redirect_to group_messages_path
      end
    end

    context "when message body empty" do
      it "can't saves the new message" do
        expect { post :create, params: message_empty }.to change(Message, :count).by(0)
      end

      it "renders the :index" do
        post :create, params: message_empty
        expect(response).to render_template :index
      end
    end
  end
end
