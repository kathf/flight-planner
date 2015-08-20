

function formSetUp( element ) {
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
  var nameInput = "#" + input + "-name"
  var idInput = "#" + input + "-id"
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

function formSubmit() {
  $("#airport01-name").attr('disabled', 'true');
  $("#airport02-name").attr('disabled', 'true');
  $('.edit_way').submit();
}

function revertForm() {
  $("#airport01-name").removeAttr('disabled');
  $("#airport02-name").removeAttr('disabled');
}

function insertOriginInForm(origin) {
  console.log("insert origin in form");
  $("#airport01-name").val(origin.name);
  $("#airport01-id").val(origin.id);
}

function getWayPath() {
  wayFormAction = $('.edit_way').attr("action");
  return wayFormAction;
}
