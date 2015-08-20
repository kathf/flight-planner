// send user's location to controller and calculate closest airport and set as @ways.origin
var detectUserLocation = function () {
  console.log("location set");
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
      document.cookie = "lat_lng=" + escape(cookie_val);
    });
  };
}
