class AirportQueryHelper

  def initialize(term)
    @term = term
  end

  def name_query
    Airport.where('name LIKE ?',"%#{@term}%")
  end

  def city_query
    Airport.where('city LIKE ?',"%#{@term}%")
  end

  def country_query
    Airport.where('country_name LIKE ?',"%#{@term}%")
  end

  # other attributes to search
  # fs
  # iata
  # icao
  # name
  # city
  # city_code
  # country_code
  # country_name
  # region_name

end
