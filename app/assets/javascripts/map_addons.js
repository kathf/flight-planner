// create marker for each airport saved as on the user's WAY
function createWayMarkers(map, wayAirports, wayAirportMarkers, icon, infowindow) {
  console.log("creating markers for way airports");
  $.each(wayAirports, function(airportID, airport) {
    var marker = createMarker(map, airportID, airport, wayAirportMarkers, icon);
    google.maps.event.addListener(marker, 'mouseover', function() {
      console.log("here");
      openInfowindow(map, marker, infowindow);
    });
  });
};

// create markers for selection of airports sent from ways controller
function createOptionMarkers(map, optionAirports, optionAirportMarkers, icon, infowindow, flightPath, origin, destination_attribute) {

  console.log("creating markers for option airports");

  $.each(optionAirports, function(airportID, airport) {

    var marker = createMarker(map, airportID, airport, optionAirportMarkers, icon);

    google.maps.event.addListener(marker, 'mouseover', function() {
      setFlightPathCoords(flightPath, origin, marker);
      openInfowindow(map, marker, infowindow);
    });

    google.maps.event.addListener(marker, 'click', function() {
      $("#"+destination_attribute+"-name").val(marker.name);
      $("#"+destination_attribute+"-id").val(marker.id);
      $("#btn-submit").click();
    });

  });
};


// create marker and add to specified collection
function createMarker(map, airportID, airport, collection, icon) {
  var latLng = new google.maps.LatLng(airport.latitude, airport.longitude);
  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: icon,
    airport: airport
  });
  collection.push(marker);
  return marker;
};



// create one generic infowindow to be updated by event listener on each airport marker and set event listener to close it whenever user clicks elsewhere on the map
function createInfoWindow(map) {
  console.log("creating info window");
  infowindow = new google.maps.InfoWindow();
  google.maps.event.addListener(map, 'mouseover', function() {
    infowindow.close();
  });
  return infowindow;
}

// create generic flight path line - will be visible when user hovers over airport
function createFlightPath(map) {
  flightPath = new google.maps.Polyline({
    map: map,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });
  google.maps.event.addListener(map, 'mouseover', function() {
    flightPath.setVisible(false);
  });
  return flightPath;
}

// open infowindow
function openInfowindow(map, marker, infowindow) {
  infowindow.setContent( markerContent(marker.airport) );
  infowindow.open(map, marker);
  styleInfowindow(infowindow);
}

function styleInfowindow(infowindow) {
  var elementsToStyle = $(".gm-style-iw").prev().children();
  $(".gm-style-iw").next().detach();
  elementsToStyle.css("border-radius", "25px");
}

// content string for infowindow
function markerContent(airport) {
  var contentString =
    airport.name+
    ' ('+
    airport.iata+
    ') ';
  return contentString;
};


// // add listener to marker - when clicked, open infowindow
// function createWayMarkerListeners(markers, map, infowindow) {
//   console.log("creating listeners for each way airport marker");
//   $.each(markers, function(marker) {
//     console.log(marker);
//     google.maps.event.addListener(marker, 'mouseover', function() {
//       console.log("here");
//       openInfowindow(map, marker, infowindow);
//     });
//   });
// }

// // add listener to marker - when clicked, open infowindow
// function createOptionMarkerListeners(markers, map, infowindow, flightPath, origin, destination_attribute) {
//   console.log("creating listeners for each airport option marker");
//
//   $.each(markers, function(marker) {
//     google.maps.event.addListener(marker, 'mouseover', function() {
//       setFlightPathCoords(flightPath, origin, marker);
//       // openInfowindow(map, marker, infowindow);
//     });
//
//     google.maps.event.addListener(marker, 'click', function() {
//       $("#"+destination_attribute+"-name").val(marker.name);
//       $("#"+destination_attribute+"-id").val(marker.id);
//       $("#btn-submit").click();
//     });
//
//   });
// }

// setup flight path lines (when user hovers over)
function setFlightPathCoords(flightPath, origin, marker) {
  flightPath.setVisible(true);
  var flightPlanCoordinates = [
    new google.maps.LatLng(origin.airport.latitude, origin.airport.longitude),
    marker.position
  ];
  flightPath.setPath(flightPlanCoordinates);
}

function deleteMarkers(markers) {
  $.each(markers, function(i,marker) {
    marker.setMap(null);
  });
  markers = [];
};
