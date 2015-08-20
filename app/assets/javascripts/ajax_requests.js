// ajax request to get all airports to mark, including origin and destination
function getDataFromWaysController(url, optionAirports, wayAirports) {
  $.getJSON(url, function(data) {
    if ( data != null ){
      console.log("ajax request from index action");
      optionAirports = data.optionAirports;
      wayAirports = data.wayAttributes;

      origin_attribute = data.origin_attribute;
      destination_attribute = data.destination_attribute;

      $.each(wayAirports, function(attr, value) {
        createWayMarker(map, value, wayAirports);
      });

      setCurrentLocationAsCentre(map, origin_attribute);

      createStopoverMarkers(optionAirports);

    }
  });
}
