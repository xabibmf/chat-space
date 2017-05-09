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
      get :index, group_id: group
      expect(response).to render_template :index
    end
  end
end
