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

  map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
  return map;
}

// centre map around origin's longitude (from ajax request)
function setCurrentLocationAsCentre(map, wayAirports, origin_attribute) {
  ("setting current location as map centre");
  var origin = wayAirports[origin_attribute];
  var latLng = new google.maps.LatLng(39, origin.longitude);
  map.setCenter(latLng);
}
