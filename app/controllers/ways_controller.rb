class WaysController < ApplicationController
  before_action :set_way, only: :update

  #get user's location from cookie - this is called from javascript file on window load
  def set_location
    render json: {origin: closest_airport}
  end

  def index
    @way = Way.create!
    if closest_airport.id?
      @destinations = WayCalculator.new(orig: closest_airport).calculate_destinations
      response = { destinations: @destinations }
    end
    respond_to do |format|
      format.html { @way }
      format.json { render json: response }
    end
  end

  # user inputs origin and destination, returns json of airport results
  def update
    if @way.update_attributes(way_params)
      results = WayCalculator.new(orig: @way.origin, dest: @way.destination).calculate_stopovers
      render json: results
    else
      flash[:notice] = 'Wrong way'
      redirect_to action: :index
    end
  end

  private

  def closest_airport
    if cookies[:lat_lng]
      @current_location = cookies[:lat_lng].split("|")
      return Airport.closest(origin: @current_location)[0]
    else
      return Airport.find(15913)
    end
  end

  def way_params
    params.require(:way).permit(:origin_id, :destination_id)
  end

  def set_way
    @way = Way.find(params[:id])
  end

end
