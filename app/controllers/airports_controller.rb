class AirportsController < ApplicationController
  before_action :get_term

  def index
    results = AirportQueryHelper.new(@term).name_query
    respond_to do |format|
      format.html
      format.json { render json: results.to_json }
    end
  end

  def get_term
    @term = params[:term]
  end

end
