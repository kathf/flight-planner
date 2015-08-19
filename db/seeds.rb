# require 'csv'
#
# airports_array = FlightStats::Airport.actives
#
# airports_array.each do |airport|
#   Airport.create!(
#     fs: airport.fs,
#     iata: airport.iata,
#     icao: airport.icao,
#     name: airport.name,
#     city: airport.city,
#     country_code: airport.country_code,
#     country_name: airport.country_name,
#     region_name: airport.region_name,
#     latitude: airport.latitude,
#     longitude: airport.longitude,
#     elevation_feet: airport.elevation_feet,
#     classification: airport.classification
#   )
# end
#
# # flight data from http://openflights.org/
# CSV.foreach("db/seeds/routes3.csv", :headers => true) do |row|
#   row_hash = row.to_hash
#   set_origin = Airport.find_by(iata: row_hash["origin"])
#   set_dest = Airport.find_by(iata: row_hash["destination"])
#   if set_origin && set_dest
#     Route.find_or_create_by!(destination_id: set_dest.id, origin_id: set_origin.id)
#   end
# end
