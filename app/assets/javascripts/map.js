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

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

  loadPoints();
  loadLines();
  loadPolygons();
  
  map.on('moveend', loadPoints);
  map.on('moveend', loadLines);
  map.on('moveend', loadPolygons);
    

  $("#name").typeahead({
    source: function(query, process) { return $.get("points/search.json", { query: query }, function (data) { process(data); } ); },
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
