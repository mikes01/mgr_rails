// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs

//= require leaflet
//= require bootstrap-sprockets
//= require bootstrap3-typeahead.min
//= require wicket
//= require wicket-leaflet
//= require toastr
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  
  
 toastr.options = {
                  "closeButton": false,
                  "debug": false,
                  "positionClass": "toast-bottom-right",
                  "onclick": null,
                  "showDuration": "300",
                  "hideDuration": "1000",
                  "timeOut": "5000",
                  "extendedTimeOut": "1000",
                  "showEasing": "swing",
                  "hideEasing": "linear",
                  "showMethod": "fadeIn",
                  "hideMethod": "fadeOut"
              }

});

$(document).on('ajax:success', '#remote_form', function(e, data, status, xhr){
      toastr.success('New object is added!', 'Success')
      showForm({html: ""})
      point = wkt.read(data.coordinates).components[0]
      if(Array.isArray(point))
        point = point[0]
      map.setView([point.y, point.x])
    }).on('ajax:error', '#remote_form', function(e, xhr, status, error){
      showForm(xhr.responseJSON)
    });

$(document).on('turbolinks:load', function() {
  $('#point').click(function () {
    console.log('jQuery.click()');
    $.ajax({
      url: '/places/render_form',
      method: 'POST',
      data: { id: 1 }
    }).done(showForm)
      .error(showErrorAlert);
    return true;
  });

  $('#line').click(function () {
    console.log('jQuery.click()');
    $.ajax({
      url: '/lines/render_form',
      method: 'POST',
      data: { id: 1 }
    }).done(showForm)
      .error(showErrorAlert);
    return true;
  });

  
});

showForm = function(data) {
  $('#form-holder').html(data.html);
}

showErrorAlert = function(data) {
  if(data.status == 401) {
    window.location.reload();
  }
  else {
    alert('Something went wrong. Please try again later.');
  }
}