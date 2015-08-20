module WaysHelper

  # if the attribute number (i) is less than the number of airports already selected by the user return "text", otherwise "hidden"
  def hide_some_inputs(i, way_trimmed)
    return "hidden" if i > way_trimmed.size + 1
  end

  def hide_last_btn(i, way_trimmed)
    return "hidden" if i >= way_trimmed.size + 1
  end

end
