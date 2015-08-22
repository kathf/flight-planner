function setUpForms(wayAirports, destination_attribute) {
  console.log("set up forms to respond to map clicks");

  formSetUp("#" + destination_attribute + "-name");
  autocomplete(destination_attribute);

  $.each(wayAirports, function(airportID, airport){
    formSetUp("#" + airportID + "-name");
    autocomplete(airportID);
  });
};

function formSetUp( element ) {
  console.log("form focus");
  $( element ).focusin(function() {
    var presentValue = this.value;
    this.value = '';
    $( element ).focusout(function() {
      if (this.value == "") {
        this.value = presentValue;
      }
    });
  });
}

function autocomplete(input) {
  console.log("form autocomplete");
  var nameInput = "#" + input + "-name";
  var idInput = "#" + input + "-id";

  $( nameInput ).autocomplete({
    minLength: 2,
    source: "/airports/search.json",
    select: function(event, ui) {
      $( nameInput ).val(ui.item.name);
      $( idInput ).val(ui.item.id);
      return false;
      }
    })
    .data( "uiAutocomplete" )._renderItem = function( ul, item ) {
    return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( "<a>" + item.name + " (" + item.iata + "), " + item.city + " " + item.country_name + "</a>" )
        .appendTo( ul );
    };
}

function formSubmit(wayAirports) {
  $.each(wayAirports, function(airport){
    $("#" + airport + "-name").attr('disabled', 'true');
  });
  $('.edit_way').submit();
}

function revertForm(wayAirports) {
  $.each(wayAirports, function(airport){
    $("#" + airport + "-name").removeAttr('disabled');
  });
}
//
// function insertOriginInForm(origin) {
//   console.log("insert origin in form");
//   $("#airport01-name").val(origin.name);
//   $("#airport01-id").val(origin.id);
// }

function getWayPath() {
  wayFormAction = $('.edit_way').attr("action");
  return wayFormAction;
}
