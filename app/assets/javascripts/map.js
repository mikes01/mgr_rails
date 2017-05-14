var renderedPoints = [];
var renderedLines = [];
var renderedPolygons = [];
var map = null;

$(document).on('turbolinks:load', function() {
  map = L.map('map', {
      center: [51.1000000, 17.0333300],
      zoom: 16
  });

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

loadLines = function() {
  parameters = getMapBounds()
  parameters.road_types = lineTypes
  $.get("lines.json", { data: parameters },
    function (data) {
      if(renderLines) {
        var lines = []
        data.forEach(function(line) {
          lines.push(wkt.read( line.coordinates ).toObject({title: line.name})  )
        });
        var polylines = L.layerGroup(lines).addTo(map);
        lines.forEach(function(line) {
          line.openPopup()
        });
        clearLines();
        renderedLines = polylines;
      }
    });
}

clearLines = function() {
  map.removeLayer(renderedLines);
}

loadPolygons = function() {
  parameters = getMapBounds()
  parameters.unit_types = polygonTypes
  $.get("polygons.json", { data: parameters },
    function (data) {
      if(renderPolygons) {
        var polygons = []
        data.forEach(function(polygon) {
          polygons.push(wkt.read( polygon.coordinates ).toObject())
        });
        var polygonsToRender = L.layerGroup(polygons).addTo(map);
        clearPolygons();
        renderedPolygons = polygonsToRender;
      }
    });
}

clearPolygons = function() {
  map.removeLayer(renderedPolygons);
}