$(document).on('ajax:success', '#polygon_remote_form', function(e, data, status, xhr){
      toastr.success('New polygon is added!', 'Success')
      point = wkt.read(data.coordinates).components[0][0][0]
      map.setView([point.y, point.x])
      $(".form-horizontal").hide()
    }).on('ajax:error', '#polygon_remote_form', function(e, xhr, status, error){
      $("#polygon_remote_form_holder").html(xhr.responseJSON.html)
    });

$(document).on('turbolinks:load', function() {
  $('#polygon').click(function () {
    $(".form-horizontal").hide()
    $("#polygon_remote_form").show()
    return true;
  });
});