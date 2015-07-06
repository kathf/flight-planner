class WaysController < ApplicationController
  before_filter :set_location

  # this method won't work as a private method...why not?
  def set_location
    @current_location = [ params[:lat], params[:lon] ]
    @origin_airport_id = Airport.closest(origin: @current_location)[0].id
    # redirect_to action: :index
  end

  def index
    @way = Way.create!(origin_id: @origin_airport_id)
    byebug
    # stopover_airports = Stopover.stopover_relation(@origin, @destination)
    #
    # # gon gem used to send data to js files
    # # mapped to a hash with only required attributes to quicken load time
    # gon.airports = stopover_airports.map do |a|
    #   {
    #     name: a.name,
    #     city: a.city,
    #     city_code: a.city_code,
    #     country_code: a.country_code,
    #     country_name: a.country_name,
    #     region_name: a.region_name,
    #     latitude: a.latitude,
    #     longitude: a.longitude
    #   }
    # end
  end

  def create
    @way = Way.create!(way_params)
  end

  def update
    @way = Way.update_attributes!(way_params)
  end

  private

  def way_params
    params.require(:way).permit(:origin_id, :destination_id)
  end

end
