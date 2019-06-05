class PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_place, only: [:show]

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)
    @place.user = @user
    if @place.save
      redirect_to root_path, notice: 'Location shared!'
    else
      redirect_to root_path, alert: 'All fields are mandatory!!'
    end
  end

  private

    def set_user
      @user = current_user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, shared_with: [], location_attributes: [:lat, :lng])
    end
end
