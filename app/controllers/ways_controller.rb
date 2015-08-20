class WaysController < ApplicationController
  before_action :set_way, only: [:update, :show]

  def index
    create
    @way_airport_helper = WayService.new(@way)
    @way_trimmed = attribute_trimmer
    respond_to do |format|
      format.html
      format.json { render json: json_constructor }
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
    way_airport_helper = WayService.new(@way)
    @inputs_setter = way_airport_helper.count_airports #number of input fields required
    response = json_constructor(way_airport_helper)
    respond_to do |format|
      format.html
      format.json { render json: response }
    end
  end

  # Called from javascript file on window load
  def set_closest_airport_to_user
    render json: {origin: closest_airport}
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

  # remove attributes of @way whose value is blank
  def attribute_trimmer
    way_trimmed = @way.attributes
    way_trimmed.delete_if { |k,v| !v || k == "id"}
    return way_trimmed
  end

  def json_constructor
    response = {
      optionAirports: @way_airport_helper.option_airports,
      wayAttributes: @way_airport_helper.way_airports,
      origin_attribute: @way_airport_helper.origin_attribute,
      destination_attribute: @way_airport_helper.destination_attribute
    }
  end

end
