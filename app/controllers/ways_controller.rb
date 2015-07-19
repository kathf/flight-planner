class WaysController < ApplicationController
  before_action :set_way, only: :update

  #get user's location from cookie - this is called from javascript file on window load
  def set_location
    render json: {origin: closest_airport}
  end

  def index
    @way = Way.create(airport01: closest_airport)
    @inputs_setter = WayAirportCounter.new(@way.attributes).count_airports + 1 #sets the number of form inputs based on the airports selected already plus 1
    @destinations = RouteCalculator.new(orig: closest_airport).calculate_destinations
    response = { destinations: @destinations }
    respond_to do |format|
      format.html
      format.json { render json: response }
    end
  end

  # user inputs origin and destination, returns json of airport results
  def update
    if @way.update_attributes(way_params)
      results = RouteCalculator.new(orig: @way.airport01, dest: @way.airport02).calculate_stopovers
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
      return Airport.find(rand(18925)+1)
    end
  end

  def way_params
    params.require(:way).permit(
      :airport01_id,
      :airport02_id,
      :airport03_id,
      :airport04_id,
      :airport05_id,
      :airport06_id,
      :airport07_id,
      :airport08_id,
      :airport09_id,
      :airport10_id
      )
  end

  def set_way
    @way = Way.find(params[:id])
  end

end
