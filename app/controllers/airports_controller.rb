class AirportsController < ApplicationController
  before_action :get_term

  def search
    results = Airport.search_all_columns(@search_term)
    respond_to do |format|
      format.html
      format.json { render json: results.to_json }
    end
  end

  private

  def get_term
    @search_term = params[:term]
  end

end
