class AirportsController < ApplicationController
  before_action :get_term

  def index
    results = Airport.search_all_columns(@term)
    respond_to do |format|
      format.html
      format.json { render json: results.to_json }
    end
  end

  def get_term
    @term = params[:term]
  end

end
