class AirportsController < ApplicationController

  def index
    gon.airports = Airport.limit(10)
  end
end
