JSON.parse(File.read("db/airports.json")).each do |hash|
  if hash["type"] == "airport"
    Airport.create!(
    iata: hash["iata"],
    lon: hash["lon"],
    iso: hash["iso"],
    status: hash["status"],
    name: hash["name"],
    continent: hash["continent"],
    size: hash["size"],
    lat: hash["lat"]
    )
  end
end
