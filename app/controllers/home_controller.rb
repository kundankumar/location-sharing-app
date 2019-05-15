class HomeController < ApplicationController
  before_action :set_user
  respond_to :html, :js

  def index
    @place = Place.new
    @place.build_location
    # @place.location = Location.new
    # @place.location.build
    @places = Place.all
  end

  def all_users
    @all_users = User.all
  end

  def create
    @place = Place.new place_params
    @place.user = @user
    if @place.save
      redirect_to root_path, notice: 'Location shared!'
    else
      render :new
    end
  end

  private
    def set_user
      @user = current_user
    end

    def place_params
      params.require(:place).permit(:name, location_attributes: [:lat, :lng])
    end

end
