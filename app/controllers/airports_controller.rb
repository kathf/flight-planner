class AirportsController < ApplicationController
  # before_action :set_origin, only: :index

  def index
    @origin = Airport.find(1)
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

  private

  def set_origin
    @origin = Airport.find(params[:id])
  end

  def set_destination
    @destination = Airport.find(params[:id])
  end

end
