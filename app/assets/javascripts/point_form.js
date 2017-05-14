$(document).on('ajax:success', '#place_remote_form.new', function(e, data, status, xhr){
  toastr.success('New point is added!', 'Success')
  point = wkt.read(data.coordinates).components[0]
  map.setView([point.y, point.x])
  $(".form-horizontal").hide()
}).on('ajax:error', '#place_remote_form.new', function(e, xhr, status, error){
  $("#place_remote_form_holder").html(xhr.responseJSON.html)
});

$(document).on('turbolinks:load', function() {
  $('#point').click(function () {
    $(".form-horizontal").hide()
    $("#place_remote_form.new").show()
    return true;
  });
});

$(document).on('ajax:success', '#place_remote_form.edit', function(e, data, status, xhr){
  if(jQuery.isEmptyObject(data)) {
    return true;
  }
  toastr.success('The point is updated!', 'Success')
  point = wkt.read(data.coordinates).components[0]
  map.setView([point.y, point.x])
  $(".form-horizontal").hide()
}).on('ajax:error', '#place_remote_form.edit', function(e, xhr, status, error){
  $("#edit_place_remote_form_holder").html(xhr.responseJSON.html)
});

$(document).on('ajax:success', '#place_remote_form.edit a', function(e, data, status, xhr){
  toastr.success('The point is deleted!', 'Success')
  loadPlaces()
  $(".form-horizontal").hide()
}).on('ajax:error', '#place_remote_form.edit a', function(e, xhr, status, error){
  $("#edit_place_remote_form_holder").html(xhr.responseJSON.html)
});