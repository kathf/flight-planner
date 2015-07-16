class WaysController < ApplicationController
  before_action :set_way, only: :update

  #get user's location from cookie
  def set_location
    current_location = cookies[:lat_lng].split("|")
    @origin = Airport.closest(origin: current_location)[0] # query returns array so select first element
    @way = Way.create!(origin: @origin)
    respond_to do |format|
      format.json { render json: {origin: @origin} }
      format.html { redirect_to action: :index }
    end
  end

  def index
    @way = Way.last
    @destinations = WayCalculator.new(orig: @way.origin).calculate_destinations
    response = { destinations: @destinations }
    respond_to do |format|
      format.html { @way }
      format.json { render json: response }
    end
  end

  # user inputs origin and destination, returns json of airport results
  def update
    if @way.update_attributes(way_params)
      puts "------------- WAY UPDATED ----------------"
      results = WayCalculator.new(orig: @way.origin, dest: @way.destination).calculate_stopovers
      render json: results
    else
      puts "WAY NOT UPDATED - SOME SORT OF ERROR"
      flash[:notice] = 'not updated'
      redirect_to action: :index
    end
  end

  private

  def way_params
    params.require(:way).permit(:origin_id, :destination_id)
  end

  def set_way
    @way = Way.find(params[:id])
  end

end
