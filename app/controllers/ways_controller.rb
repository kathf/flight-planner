class WaysController < ApplicationController
  before_action :set_location, only: [:index]
  before_action :set_way, only: :update

  #get user's location from cookie
  def set_location
    current_location = cookies[:lat_lng].split("|")
    @origin = Airport.closest(origin: current_location)[0] # query returns array so select first element
    @way = Way.create!(origin: @origin)
  end

  def index
    @way = Way.last
    airports = WayCalculator.new(orig: @origin).calculate_destinations
    response = { origin: @origin, airports: airports }
    respond_to do |format|
      format.html { @way }
      format.json { render json: response }
      # Jway UI autocomplete
    end

    @airports = Airport.all #for dropdown list of airports to select orig/dest from
    # @airports << Airport.find(15913)
    # @airports << Airport.find(268)

    # @stopovers = Stopover.stopover_relation({orig: @origin}) #confusingly, this is actually an AR relation of stopover objects
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
