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
    way_airport_helper = WayAirportHelper.new(@way)
    @inputs_setter = way_airport_helper.count_airports #sets the number of form inputs based on the airports selected already
    airports_to_mark = way_airport_helper.airports_form_info_hash
    respond_to do |format|
      format.html
      format.json { render json: { "airportsToMark": airports_to_mark } }
    end
  end

  def create
    @way = Way.create(airport01: closest_airport)
  end

  # user inputs origin and destination, returns json of airport results
  #TODO: ajax request in js to update index view
  def update
    if @way.update_attributes(way_params)
      flash[:notice] = 'Winning!'
    else
      flash[:notice] = 'Way not updated'
    end
    redirect_to action: :index, status: 303, id: @way.id
    # { 'params[id]' => @way.id, method: 'GET'}
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
