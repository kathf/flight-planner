class WaysController < ApplicationController
  before_action :set_way, only: [:update, :show]

  # Called from javascript file on window load
  def set_closest_airport_to_user
    render json: {origin: closest_airport}
  end

  def index
    @way = create
    way_airport_helper = WayAirportHelper.new(@way)
    @inputs_setter = 2 #number of input fields required
    response = json_constructor(way_airport_helper, @way.id)
    respond_to do |format|
      format.html
      format.json { render json: response }
    end
  end

  def create
    @way = Way.create(airport01: closest_airport)
  end

  def update
    @way.update_attributes(way_params)
    # redirect_to way_path, status: 303, format: 'html'
    render nothing: true
  end

  def show
    way_airport_helper = WayAirportHelper.new(@way)
    @inputs_setter = way_airport_helper.count_airports #number of input fields required
    response = json_constructor(way_airport_helper, @way.id)
    respond_to do |format|
      format.html
      format.json { render json: response }
    end
  end


  private

  #get user's location from cookie and calculates closest airport. If location not shared, it returns a randomly selected airport
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

  def json_constructor(way_airport_helper, id)
    airports_to_mark = way_airport_helper.airports_form_info_hash
    origin = way_airport_helper.origin  #something here that returns the number of inputs, the origin and/or destination for the search query and an object of all airports to mark
    destination = way_airport_helper.destination
    response = { airportsToMark: airports_to_mark, origin: origin, destination: destination, wayID: id }
  end

end
