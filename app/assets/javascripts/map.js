// initialize google map and call function to create marker for origin airport (closest to user's location)
function initializeMap() {
  console.log("initializing map");

  var myStyles =
  [{"stylers":[{"visibility":"off"}]},{"featureType":"water","stylers":[{"visibility":"on"},{"hue":"#009999"}]},{"featureType":"landscape","stylers":[{"visibility":"on"},{"color":"#000000"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#2f343b"},{"weight":1}]}]

  var myOptions = {
    center: new google.maps.LatLng(39, 135),
    zoom: 2,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    minZoom: 1,
    maxZoom: 6,
    mapTypeControl: false,
    streetViewControl: false,
    panControl: false,
    zoomControl: true,
    zoomControlOptions: {
        style: google.maps.ZoomControlStyle.SMALL,
        position: google.maps.ControlPosition.LEFT_BOTTOM
    },
    scaleControl: false,
    styles: myStyles
  };

  map = new google.maps.Map(document.getElementById("map-canvas"),
      myOptions);
  return map;
}

// ajax request to get closest airport to user's current location and (i) set as origin marker, (ii) autofill into form and (iii) centre map around origin's longitude
// function setClosestAirportToUser() {
//   $.getJSON("/ways/set_closest_airport_to_user.json", function(data) {
//     ("set closest airport to user as origin");
//     origin = data.origin;
//     if (origin != null) {
//       setCurrentLocationAsCentre(map, origin);
//       createWayMarker(map, origin)
//       insertOriginInForm(origin);
//     };
//   });
// }


// centre map around origin's longitude (from ajax request)
function setCurrentLocationAsCentre(map, origin) {
  ("setting current location as map centre");
  var latLng = new google.maps.LatLng(39, origin.longitude);
  map.setCenter(latLng);
}


function deleteMarkers(markers) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
}

// create marker for each airport saved as on the user's WAY
function createWayMarker(map, way, wayAirportMarkers) {
  console.log("creating generic origin marker");
  var latLng = new google.maps.LatLng(way.latitude, way.longitude);
  marker = new google.maps.Marker({
    position: latLng,
    map: map,
    icon: 'http://maps.google.com/mapfiles/kml/pal3/icon53.png'
  });
  wayAirportMarkers.push(marker);
}

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
  infowindow.setContent( markerContent(marker) );
  infowindow.open(map, marker);
  styleInfowindow(infowindow);
}

function styleInfowindow(infowindow) {
  var elementsToStyle = $(".gm-style-iw").prev().children();
  $(".gm-style-iw").next().detach();
  elementsToStyle.css("border-radius", "25px");
}

// content string for infowindow
function markerContent(marker) {
  var contentString =
    marker.name+
    ' ('+
    marker.iata+
    ') ';
  return contentString;
}

// create markers for selection of airports sent from ways controller
function createStopoverMarkers(optionAirports) {
  console.log("creating stopover markers");
  $.each(airportsToMark, function() {
    var latLng = new google.maps.LatLng(this.latitude, this.longitude);
    var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        id: this.id,
        name: this.name,
        city: this.city,
        iata: this.iata,
        country: this.country_name,
        icon: 'http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=glyphish_airplane|FFFFFF'
    });
    optionAirports.push(marker);
    createMarkerListeners(marker, map, infowindow, flightPath);
  });
}

// add listener to marker - when clicked, open infowindow
function createMarkerListeners(marker, map, infowindow, flightPath) {
  console.log("creating listeners for each marker");
  google.maps.event.addListener(marker, 'mouseover', function() {
    setFlightPathCoords(flightPath, origin, marker);
    openInfowindow(map, marker, infowindow);
  });
  google.maps.event.addListener(marker, 'click', function() {
    $("#airport02-name").val(marker.name);
    $("#airport02-id").val(marker.id);
    $("#btn-submit").click();
  });
}

// setup flight path lines (when user hovers over)
function setFlightPathCoords(flightPath, origin, marker) {
  flightPath.setVisible(true);
  var flightPlanCoordinates = [
    new google.maps.LatLng(origin.latitude, origin.longitude),
    marker.position
  ];
  flightPath.setPath(flightPlanCoordinates);
}
