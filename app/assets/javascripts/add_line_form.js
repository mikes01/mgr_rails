$(document).on('ajax:success', '#line_remote_form', function(e, data, status, xhr){
      toastr.success('New line is added!', 'Success')
      point = wkt.read(data.coordinates).components[0][0]
      map.setView([point.y, point.x])
      $(".form-horizontal").hide()
    }).on('ajax:error', '#line_remote_form', function(e, xhr, status, error){
      $("#line_remote_form_holder").html(xhr.responseJSON.html)
    });

$(document).on('turbolinks:load', function() {
  $('#line').click(function () {
    $(".form-horizontal").hide()
    $("#line_remote_form").show()
    return true;
  });
});