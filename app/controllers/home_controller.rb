class HomeController < ApplicationController
  before_action :set_user
  respond_to :html, :js

  def index
    if @user
      @place = Place.new
      @place.build_location
      @places = @user.places.or(Place.shared_with_me(@user.id))
    end
  end

  def all_users
    @all_users = User.all
  end

  private
    def set_user
      @user = current_user
    end

    def place_params
      params.require(:place).permit(:name, location_attributes: [:lat, :lng])
    end

end
