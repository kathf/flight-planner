class WayAirportHelper
  attr_accessor :blank_input, :consecutive_blanks

  def initialize(way)
    @way = way
    @attrs = way.attributes
  end

  #returns a hash - first element is the number of input fields required (based on the saved atributes of @way in the way controller) - second element is the attribute position of any blank fields. This info is used to construct the form.
  def count_airports
    i = 0
    @blank_inputs = []
    @attrs.each do |attr, val|
      if (attr[0..6] == "airport") && (val.nil?)
        @blank_inputs << { attr: attr, i: i}
        break if @blank_inputs.size == 2
      end
      i +=1
    end
    @consecutive_blanks = true if ( @blank_inputs[1][:i] - @blank_inputs[0][:i] == 1 )
    return @blank_inputs[0][:i] if consecutive_blanks
    return @blank_inputs[1][:i]
  end

  def airports_form_info_hash
    airport_attribute_stg = "airport#{sprintf("%02d", (@blank_inputs[0][:i]))}"
    origin = @way.send(airport_attribute_stg)
    if @consecutive_blanks # if first 2 blank attributes are consecutive then calculate destination options from last airport
      RouteCalculator.new(orig: origin).calculate_destinations
    else #if not consecutive then find stopover airports to fill in blank leg
      airport_attribute_stg = "airport#{sprintf("%02d", (@blank_inputs[0][:i] + 2))}"
      destination = @way.send(airport_attribute_stg)
      RouteCalculator.new(orig: origin, dest: destination).calculate_stopovers
    end
  end
end
