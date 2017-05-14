var renderedPoints = [];
var renderedLines = [];
var renderedPolygons = [];
var map = null;

$(document).on('turbolinks:load', function() {
  map = L.map('map', {
      center: [51.1000000, 17.0333300],
      zoom: 16
  });

  map.createPane('lines');
  map.getPane('lines').style.zIndex = 500;
  map.createPane('polygons');
  map.getPane('polygons').style.zIndex = 400;

  wkt = new Wkt.Wkt();

  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

  loadPlaces();
  loadLines();
  loadPolygons();
  

  //map.on('zoomend', function() { loadPlaces(map) });
  map.on('moveend', loadPlaces);
  map.on('moveend', loadLines);
  map.on('moveend', loadPolygons);
    

  $("#name").typeahead({
    source: function(query, process) { return $.get("places/search.json", { query: query }, function (data) { process(data); } ); },
    displayText: function(item) {
      return item.name + ', ' + item.commune + ', ' + item.county + ', ' + item.voivodeship;
    },
    afterSelect: function(item) {
      point = wkt.read(item.coordinates).components[0]
      map.setView([point.y, point.x])
      
    }
  });
});

getMapBounds = function() {
  bounds = map.getBounds();
  return {
    north_east_lat: bounds.getNorthEast().lat,
    north_east_lng: bounds.getNorthEast().lng,
    south_west_lat: bounds.getSouthWest().lat,
    south_west_lng: bounds.getSouthWest().lng
  }
}
