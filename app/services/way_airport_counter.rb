class WayAirportCounter

  def initialize(attrs)
    @attrs = attrs
    @airports = Set.new
  end

  def count_airports
    i = 0
    @attrs.each do |attr, val|
      i +=1 if (attr[0..6] == "airport") && (val.is_a? Integer)
    end
    return i
  end

  # def way_airports_to_set
  #   @attrs.each do |key, val|
  #     @airports << Airport.find(val) if (key[0..6] == "airport") && (val.is_a? Integer)
  #   end
  #   return @airports
  # end

end
