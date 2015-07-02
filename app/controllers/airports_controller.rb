class AirportsController < ApplicationController

  def index
    gon.airports = Airport.large
  end
end
