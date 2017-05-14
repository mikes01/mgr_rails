loadPolygons = function() {
  parameters = getMapBounds()
  parameters.unit_types = polygonTypes
  $.get("polygons.json", { data: parameters },
    function (data) {
      if(renderPolygons) {
        var polygons = []
        data.forEach(function(polygon) {
          polygons.push(wkt.read( polygon.coordinates ).toObject({
            color: polygon.color, pane: 'polygons'})
            .on('click', L.bind(onPolygonClick, null, polygon)))
        });
        var polygonsToRender = L.layerGroup(polygons).setZIndex(-1).addTo(map);
        clearPolygons();
        renderedPolygons = polygonsToRender;
      }
    });
}

onPolygonClick = function(polygon, event) {
  $(".form-horizontal").hide()
  form = $("#polygon_remote_form.edit")
  form[0].action = "polygons/" + polygon.id
  form.find('a')[0].href = form[0].action
  form.find("#polygon_name").val(polygon.name)
  form.find("#polygon_coordinates").val(polygon.coordinates)
  form.find("#polygon_unit_type").val(polygon.unit_type)
  form.find("#polygon_terc").val(polygon.terc)
  form.show()
}

clearPolygons = function() {
  map.removeLayer(renderedPolygons);
}