$(document).on('ajax:success', '#polygon_remote_form.new', function(e, data, status, xhr){
      toastr.success('New polygon is added!', 'Success')
      point = wkt.read(data.coordinates).components[0][0][0]
      map.setView([point.y, point.x])
      $(".form-horizontal").hide()
    }).on('ajax:error', '#polygon_remote_form.new', function(e, xhr, status, error){
      $("#polygon_remote_form_holder").html(xhr.responseJSON.html)
    });

$(document).on('turbolinks:load', function() {
  $('#polygon').click(function () {
    $(".form-horizontal").hide()
    $("#polygon_remote_form.new").show()
    return true;
  });
});

$(document).on('ajax:success', '#polygon_remote_form.edit', function(e, data, status, xhr){
  if(jQuery.isEmptyObject(data)) {
    return true;
  }
  toastr.success('The polygon is updated!', 'Success')
  point = wkt.read(data.coordinates).components[0][0][0]
  map.setView([point.y, point.x])
  $(".form-horizontal").hide()
}).on('ajax:error', '#polygon_remote_form.edit', function(e, xhr, status, error){
  $("#edit_polygon_remote_form_holder").html(xhr.responseJSON.html)
});

$(document).on('ajax:success', '#polygon_remote_form.edit a', function(e, data, status, xhr){
  toastr.success('The polygon is deleted!', 'Success')
  loadPolygons()
  $(".form-horizontal").hide()
}).on('ajax:error', '#polygon_remote_form.edit a', function(e, xhr, status, error){
  $("#edit_polygon_remote_form_holder").html(xhr.responseJSON.html)
});