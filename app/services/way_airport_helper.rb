class WayAirportHelper

  def initialize(attrs)
    @attrs = attrs
  end

  #returns a hash - first element is the number of input fields required (based on the saved atributes of @way in the way controller) - second element is the attribute position of any blank fields. This info is used to construct the form.
  def count_airports
    i = 1
    blank_inputs = []
    @attrs.each do |attr, val|
      (blank_inputs << i) if (attr[0..6] == "airport") && (val.nil?)
      break if blank_inputs.size == 2
      i +=1
    end
    return blank_inputs
  end

  def airports_form_info_hash
    blank_inputs = count_airports
    if ( blank_inputs[1] - blank_inputs[0] == 1 )
      airports_form_info_hash = { number_of_inputs: blank_inputs[1]}
    else
      airports_form_info_hash = { number_of_inputs: blank_inputs[0], blank: blank_inputs[0] }
    end
    return airports_form_info_hash
  end


  def next_stop_options_for_map
    hash = airports_form_info_hash
    if hash[:blank].nil?
      airport_attribute_no = hash[:number_of_inputs] #convert to 2 digit and concat into attribute name
    else
      airport_attribute_no = hash[:blank]
    end
    airport_attribute = "airport#{sprintf("%02d", airport_attribute_no)}_id"
  end

end
