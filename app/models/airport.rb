class Airport < ActiveRecord::Base
  has_one :origin, class_name: 'Route', foreign_key: 'origin_id'
  has_one :destination, class_name: 'Route', foreign_key: 'destination_id'

  validates :iata, :icao, :name, :city, :city_code, :country_code, :country_name, :region_name, :latitude, :longitude, presence: true

end
