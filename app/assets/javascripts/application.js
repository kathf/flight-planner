// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

function initializeMap() {
  console.log('initialize');
  var myOptions = {
    center: new google.maps.LatLng(22, 76.2),
    zoom: 3,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
      myOptions);

  var coords = [
      [54.97784, -1.612916],
      [55.378051, -3.435973]
  ];

  for (var i = 0; i < coords.length; i++) {
      (function(coord) {
          var latLng = new google.maps.LatLng(coord[0], coord[1]);
          var marker = new google.maps.Marker({
              position: latLng,
              map: map
          });
      })(coords[i]);
  };

  console.log(gon.airports[0].name);
}


$(window).load(function () {
  console.log('document ready');
  initializeMap();
});
