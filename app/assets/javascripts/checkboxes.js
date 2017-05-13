
var pointTypes = ["część miasta", "część wsi", "miasto", "wieś"]
var lineTypes = ["residential", "secondary", "secondary_link", "primary", "primary_link",
        "tertiary", "tertiary_link", "living_street", "service"]
var polygonTypes = ["RegistrationArea"]

var renderPoints = true
var renderLines = true
var renderPolygons = true

$(document).on('turbolinks:load', function() {
  initializeCheckboxes("points", loadPlaces, pointTypes, clearPoints, togglePoints)
  initializeCheckboxes("lines", loadLines, lineTypes, clearLines, toggleLines)
  initializeCheckboxes("polygons", loadPolygons, polygonTypes, clearPolygons, togglePolygons) 
});

togglePoints = function() {
  renderPoints = !renderPoints;
}

toggleLines = function() {
  renderLines = !renderLines;
}

togglePolygons = function() {
  renderPolygons = !renderPolygons;
}

handleMainCheckbox = function(object_name, loadFunction, array, clearFunction, toggle) {
  $("#" + object_name).bind('change', function(){
    if (this.checked){
      toggle()
      $("#" + object_name + "_checks :checkbox").attr("disabled", false);
      $("#" + object_name + "_checks :checkbox:checked").each(function () {
        array.push(this.name);
      });
      map.on('moveend', loadFunction);
      loadFunction()
    }
    else {
      toggle()
      $("#" + object_name + "_checks :checkbox").attr("disabled", true);
      array.length = 0
      map.off('moveend', loadFunction);
      clearFunction();
    }
  });
}

handleMinorCheckboxes = function(object_name, loadFunction, array) {
  $("#" + object_name + "_checks :checkbox").bind('change', function(){
    if (this.checked){
      array.push(this.name)
    }
    else {
      var index = array.indexOf(this.name);
      if (index > -1) {
        array.splice(index, 1);
      }
    }
    loadFunction()
  });
}

checkDefaults = function(object_name, loadFunction, array) {
  for (var i = 0, len = array.length; i < len; i++) {
    $("#" + object_name + "_checks :input[name='" + array[i] + "']").attr("checked", true)
  }
}

initializeCheckboxes = function(object_name, loadFunction, array, clearFunction, toggle) {
  handleMainCheckbox(object_name, loadFunction, array, clearFunction, toggle) 
  handleMinorCheckboxes(object_name, loadFunction, array)
  checkDefaults(object_name, loadFunction, array)
}

