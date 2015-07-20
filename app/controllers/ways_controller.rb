class WaysController < ApplicationController
  before_action :set_way, only: [:update]

  #get user's location from cookie - this is called from javascript file on window load
  def set_location
    render json: {origin: closest_airport}
  end

  def index
    if params[:id]
      @way = set_way
    else
      @way = create
    end
    @inputs_setter = WayAirportHelper.new(@way.attributes).airports_form_info_hash[:form_inputs] #sets the number of form inputs based on the airports selected already
    airports_to_mark = direct_route_options(closest_airport)
    respond_to do |format|
      format.html
      format.json { render json: { "airportsToMark": airports_to_mark } }
    end
  end

  def create
    @way = Way.create(airport01: closest_airport)
  end

  def direct_route_options(origin)
    direct_route_options = RouteCalculator.new(orig: origin).calculate_destinations
  end

  # user inputs origin and destination, returns json of airport results
  def update
    if @way.update_attributes(way_params)
      WayAirportHelper.new(@way.attributes).next_stop_options_for_map

      # results = RouteCalculator.new(orig: @way.airport01, dest: @way.airport02).calculate_stopovers
      # redirect_to action: :index
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
