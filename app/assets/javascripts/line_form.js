$(document).on('ajax:success', '#line_remote_form.new', function(e, data, status, xhr){
      toastr.success('New line is added!', 'Success')
      point = wkt.read(data.coordinates).components[0][0]
      map.setView([point.y, point.x])
      $(".form-horizontal").hide()
    }).on('ajax:error', '#line_remote_form.new', function(e, xhr, status, error){
      $("#line_remote_form_holder").html(xhr.responseJSON.html)
    });

$(document).on('turbolinks:load', function() {
  $('#line').click(function () {
    $(".form-horizontal").hide()
    $("#line_remote_form.new").show()
    return true;
  });
});

$(document).on('ajax:success', '#line_remote_form.edit', function(e, data, status, xhr){
  if(jQuery.isEmptyObject(data)) {
    return true;
  }
  toastr.success('The line is updated!', 'Success')
  point = wkt.read(data.coordinates).components[0][0]
  map.setView([point.y, point.x])
  $(".form-horizontal").hide()
}).on('ajax:error', '#line_remote_form.edit', function(e, xhr, status, error){
  $("#edit_line_remote_form_holder").html(xhr.responseJSON.html)
});

$(document).on('ajax:success', '#line_remote_form.edit a', function(e, data, status, xhr){
  toastr.success('The line is deleted!', 'Success')
  loadLines()
  $(".form-horizontal").hide()
}).on('ajax:error', '#line_remote_form.edit a', function(e, xhr, status, error){
  $("#edit_line_remote_form_holder").html(xhr.responseJSON.html)
});