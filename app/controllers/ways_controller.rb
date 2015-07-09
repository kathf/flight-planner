class WaysController < ApplicationController
  before_action :set_location, only: [:index]
  before_action :set_way, only: :update

  #get user's location from cookie
  def set_location
    current_location = cookies[:lat_lng].split("|")
    @origin_airport = Airport.closest(origin: current_location)[0] # query returns array so select first element
  end

  def index
    Way.delete_all
    @way = Way.create!(origin: @origin_airport)
    @stopovers = Stopover.stopover_relation({orig: @origin_airport}) #confusingly, this is actually an AR relation of stopover objects

    # @query = WayCalculator.new(@origin, @destination).calculate
    # In the view @query.results.each ...

    gon.origin = @origin_airport #use gon gem to send data to javascript
    gon.airportMarkers = @stopovers
  end

  def update
    if @way.update_attributes(way_params)
      #update map with all airport markers
    else
      flash[:notice] = "Invalid selection try again"
    end
  end

  private

  def way_params
    params.require(:way).permit(:origin_id, :destination_id)
  end

  def set_way
    @way = Way.last
  end

end
