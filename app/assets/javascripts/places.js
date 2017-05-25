loadPoints = function() {
  if(pointTypes == null ) {
    clearPoints();
    return
  }
  parameters = getMapBounds()
  parameters.object_types = pointTypes
  $.get("places.json", { data: parameters },
    function (data) {
      var markers = []
      data.forEach(function(place) {
        var markerHtmlStyles =
          "background-color: " + place.color +"; \
          width: 3rem;\
          height: 3rem;\
          display: block;\
          left: -1.5rem;\
          top: -1.5rem;\
          position: relative;\
          border-radius: 3rem 3rem 0;\
          transform: rotate(45deg);\
          border: 1px solid #FFFFFF"

        var icon = L.divIcon({
          className: 'customIcon',
          iconAnchor: [0, -5],
          html: '<span style="' + markerHtmlStyles + '" />'
        })
        markers.push(wkt.read(place.coordinates).toObject({title: place.name, icon: icon})
          .on('click', L.bind(onPlaceClick, null, place))
          .bindTooltip(place.name,
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
      clearPoints()
      renderedPoints = places;
    });
}

onPlaceClick = function(place, event) {
  $(".form-horizontal").hide()
  form = $("#place_remote_form.edit")
  form[0].action = "places/" + place.id
  form.find('a')[0].href = form[0].action
  form.find("#point-name").val(place.name)
  form.find("#point-coordinates").val(place.coordinates)
  form.find("#point-object_type").val(place.object_type)
  form.find("#point-object_class").val(place.object_class)
  form.find("#point-terc").val(place.terc)
  form.find("#point-voivodeship").val(place.voivodeship)
  form.find("#point-county").val(place.county)
  form.find("#point-commune").val(place.commune)
  form.show()
}

clearPoints = function() {
  map.removeLayer(renderedPoints);
}