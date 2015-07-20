class WayAirportHelper

  def initialize(attrs)
    @attrs = attrs
  end

  #returns a hash - first element is the number of input fields required (based on the saved atributes of @way in the way controller) - second element is the attribute position of any blank fields. This info is used to construct the form.
  def count_airports
    i = 1
    blank_inputs = []
    @attrs.each do |attr, val|
      (blank_inputs << { attr: attr, i: i} ) if (attr[0..6] == "airport") && (val.nil?)
      break if blank_inputs.size == 2
      i +=1
    end
    return blank_inputs
  end

  #keep working on this
  def airports_form_info_hash
    blank_inputs = count_airports
    if ( blank_inputs[1][:i] - blank_inputs[0][:i] == 1 )
      origin = "airport#{sprintf("%02d", (blank_inputs[1][:i] - 1))}_id"
      RouteCalculator.new(orig: origin).calculate_destinations
    else
      origin = "airport#{sprintf("%02d", (blank_inputs[0][:i] - 1) )}_id"
      destination = "airport#{sprintf("%02d", (blank_inputs[0][:i] + 1) )}_id"
      RouteCalculator.new(orig: origin, dest: destination).calculate_stopovers
    end
  end
end
