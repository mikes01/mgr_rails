$(document).on('ajax:success', '#place_remote_form', function(e, data, status, xhr){
      toastr.success('New point is added!', 'Success')
      point = wkt.read(data.coordinates).components[0]
      map.setView([point.y, point.x])
      $(".form-horizontal").hide()
    }).on('ajax:error', '#place_remote_form', function(e, xhr, status, error){
      $("#place_remote_form_holder").html(xhr.responseJSON.html)
    });

$(document).on('turbolinks:load', function() {
  $('#point').click(function () {
    $(".form-horizontal").hide()
    $("#place_remote_form").show()
    return true;
  });
});