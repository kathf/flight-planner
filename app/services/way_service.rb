class WayService
  attr_accessor :blank_input, :consecutive_blanks, :origin_attribute, :destination_attribute

  def initialize(way)
    @way = way
    @attrs = attributes_without_id
  end



  def attributes_without_id
    res = @way.attributes
    res.delete("id")
    return res
  end

  def non_blank_attributes
    counter = 0
    @attrs.each do |attr, val|
      counter += 1 if !val.nil?
    end
    @origin_attribute = "airport#{sprintf( "%02d", counter )}"
    @destination_attribute = "airport#{sprintf( "%02d", counter + 1 )}"
    return counter
  end

  # returns all airports that can be reached by direct flight from the supplied origin
  def option_airports
    RouteCalculator.new(orig: origin).calculate_destinations
  end


### some issue here to sort out !!!!!!
  def way_airports
    hash = {}
    @attrs.each_pair do |attr, val|
      hash[:attr] = Airport.find(val).to_json
    end
    return hash
  end

  #returns an integer for how many input fields are required for the form (based on how many airport attributes are already saved and if/where there are blank attributes)
  # def count_airports
  #   i = 0
  #   @blank_inputs = []
  #   @attrs.each do |attr, val|
  #     if (attr[0..6] == "airport") && (val.nil?)
  #       @blank_inputs << { attr: attr, i: i}
  #       break if @blank_inputs.size == 2
  #     end
  #     i +=1
  #   end
  #   @consecutive_blanks = true if ( @blank_inputs[1][:i] - @blank_inputs[0][:i] == 1 )
  #   return @blank_inputs[0][:i] if @consecutive_blanks
  #   return @blank_inputs[1][:i]
  # end
  #
  # def airports_form_info_hash
  #   count_airports
  #   origin_airport = origin
  #   if @consecutive_blanks # if first 2 blank attributes are consecutive then calculate destination options from last airport
  #     RouteCalculator.new(orig: origin_airport).calculate_destinations
  #   else #if not consecutive then find stopover airports to fill in blank leg
  #     destination_airport = destination
  #     RouteCalculator.new(orig: origin, dest: destination_airport).calculate_stopovers
  #   end
  # end
  #
  def origin
    # origin_airport = "airport#{sprintf("%02d", non_blank_attributes)}"
    origin = @way.send(@origin_attribute)
  end
  #
  # def destination
  #   destination_airport_attribute_string = "airport#{sprintf("%02d", (@blank_inputs[0][:i] + 1))}"
  #   destination = @way.send(destination_airport_attribute_string)
  # end
end
