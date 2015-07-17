class Airport < ActiveRecord::Base
  has_one :origin, class_name: 'Route', foreign_key: 'origin_id'
  has_one :destination, class_name: 'Route', foreign_key: 'destination_id'

  has_and_belongs_to_many :queries, :join_table => "results", :foreign_key => "query_id"

  validates :iata, :icao, :name, :city, :city_code, :country_code, :country_name, :region_name, :latitude, :longitude, presence: true

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  include PgSearch
  pg_search_scope :search_all_columns,
                  against: [ :name, :city, :country_name, :iata ],
                  using: {
                    tsearch: {prefix: true},
                    trigram: {}
                  }

end
