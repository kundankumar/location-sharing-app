require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "Home Controller" do
    let (:user) { FactoryBot.create(:user) }
    let (:place1) { FactoryBot.create(:place, user_id: user.id) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

   it "renders the index template" do
     get :index
     expect(response).to render_template("index")
   end

   it 'renders with user and all his/her place instances' do
     get :index

     assert_response :success
     expect(assigns(:user)).to eq(user)
     expect(assigns(:places)).to eq([place1])
   end

   it 'renders places shared with user' do
     user2 = FactoryBot.create(:user)
     place2 = FactoryBot.create(:place, user_id: user2.id, shared_with: [user.id])
     get :index

     assert_response :success
     expect(assigns(:places).to_a).to eq([place2])
   end

   it "renders the all users template" do
     user3 = FactoryBot.create(:user)

     get :all_users
     assert_response :success
     expect(response).to render_template("all_users")
     expect(assigns(:all_users).to_a).to eq([user, user3])
   end

  end
end
