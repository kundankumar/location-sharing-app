require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "Users Controller" do
    let (:user) { FactoryBot.create(:user) }
    let (:place) { FactoryBot.create(:place, user_id: user.id) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

   it "renders the show template" do
     get :show, params: { username: user.username }
     expect(response).to render_template("show")
   end

   it 'renders with user and public places' do
     user2 = FactoryBot.create(:user)
     place2 = FactoryBot.create(:place, user_id: user.id, shared_with: [])
     place3 = FactoryBot.create(:place, user_id: user.id, shared_with: [user2.id])
     get :show, params: { username: user.username }

     assert_response :success
     expect(assigns(:user)).to eq(user)
     expect(assigns(:places).to_a).to eq([place2])
   end

  end

end
