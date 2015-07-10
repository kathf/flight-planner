require 'set'

class WayCalculator
  def initialize(options = {})
    @origin = options[:orig]
    @destination = options[:dest]
  end

  def calculate_destinations
    query = Query.create(origin: @origin)
    airports_result = Route.leave_from(@origin)
    if airports_result.any?
      airports_result.each do |airport_id|
        query.airports << Airport.find(airport_id)
      end
    end
    return query.airports
  end

  def calculate_stopovers
    query = Query.create(origin: @origin, destination: @destination)
    airports_result = Route.find_stopovers(@origin, @destination)
    if airports_result.any?
      airports_result.each do |airport_id|
        query.airports << Airport.find(airport_id)
      end
    end
    return query.airports
  end
end
