// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require leaflet
//= require bootstrap-sprockets
//= require bootstrap3-typeahead.min
//= require wicket
//= require wicket-leaflet
//= require_tree .

$(document).on('turbolinks:load', function() {
  var map = L.map('map', {
      center: [51.1000000, 17.0333300],
      zoom: 16
  });

  wkt = new Wkt.Wkt();
  
  updateMap(map);
  

  //map.on('zoomend', function() { loadPlaces(map) });
  map.on('moveend', function() { updateMap(map) });
    

  $("#name").typeahead({
    source: function(query, process) { return $.get("places/search.json", { query: query }, function (data) { process(data); } ); },
    displayText: function(item) {
      return item.name + ', ' + item.commune + ', ' + item.county + ', ' + item.voivodeship;
    },
    afterSelect: function(item) {
      console.log(item);
      map.setView([item.lat, item.lng])
      
      L.marker([item.lat, item.lng], { title: item.name }).bindTooltip(item.name, 
    {
        permanent: true, 
        direction: 'top'
    }).addTo(map);
    }
  });
});

updateMap = function(map) {
  layers = []
  map.eachLayer(function (layer) {
    layers.push(layer);
  });

  var bounds = map.getBounds();
  var parameters = {
    north_east_lat: bounds.getNorthEast().lat,
    north_east_lng: bounds.getNorthEast().lng,
    south_west_lat: bounds.getSouthWest().lat,
    south_west_lng: bounds.getSouthWest().lng
  }

  loadPlaces(map, parameters);
  loadLines(map, parameters);
  layers.forEach(function (layer) {
    map.removeLayer(layer);
  });
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
}

loadPlaces = function(map, parameters) {
  $.get("places.json", { data: parameters },
    function (data) {
      var markers = []
      data.forEach(function(place) {
        markers.push(L.marker([place.lat, place.lng],
          { title: place.name }).bindTooltip(place.name, 
            {
              permanent: true, 
              direction: 'top'
            }
          ))
      })
      var places = L.layerGroup(markers);
      var overlayMaps = {
          "Places": places
      };
      places.addTo(map);
    });
}

loadLines = function(map, parameters) {
  $.get("lines.json", { data: parameters },
    function (data) {
      
      var lines = []
      data.forEach(function(line) {
        lines.push(wkt.read( line.coordinates ).toObject())
      });
      console.log(lines);
      var polylines = L.layerGroup(lines).addTo(map);
    });
}