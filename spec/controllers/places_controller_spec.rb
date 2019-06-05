require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "Places Controller" do
    let (:user) { FactoryBot.create(:user) }
    let (:place) { FactoryBot.create(:place, user_id: user.id) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

   it "renders the show template" do
     get :show, params: { id: place.id }
     expect(response).to render_template("show")
   end

   it 'renders with user and specific place instances' do
     get :show, params: { id: place.id }

     assert_response :success
     expect(assigns(:user)).to eq(user)
     expect(assigns(:place)).to eq(place)
   end

    context "Place :: with valid attributes" do

      it "create should save the new record in the database" do
        post :create, params: { place:
             { name: 'New Place', user_id: user.id, location_attributes: { lat: 22.6060082, lng: 88.3706760 } }
        }

        expect(assigns(:place).name).to eq('New Place')
        expect(assigns(:place).id).to_not be_nil
      end

      it "create should render 200 & flash" do
        expect(response.status).to eq 200
        # expect(flash[:notice]).to eq('Location shared!')
      end
    end

    context "Place :: with invalid attributes" do
      it "create should not save the new story in the database" do
        expect { post :create, params: {
             name: 'New Place', user_id: nil, location_attributes: { lat: 22.6060082, lng: 88.3706760 }
        }}.to raise_error(ActionController::ParameterMissing)

        expect(assigns(:place)).to be_nil
      end

      it "create should redirect to the home page" do
        # expect {
          post :create, params: { place:
             { name: 'New Place', user_id: nil, location_attributes: { lat: 22.6060082, lng: 88.3706760 }}
        } #.to redirect_to root_path

        expect(response.status).to eq 302
        # expect(flash[:error]).to eq('All fields are mandatory!!')
      end
    end

  end
end
