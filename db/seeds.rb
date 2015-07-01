JSON.parse(File.read("db/airports.json")).each do |hash|
  Airport.create!(
  iata: hash["iata"],
  lon: hash["lon"],
  iso: hash["iso"],
  status: hash["status"],
  name: hash["name"],
  continent: hash["continent"],
  typey: hash["type"],
  lat: hash["lat"]
  )
end
