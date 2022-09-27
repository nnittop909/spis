$( document ).on('turbolinks:load', function() {
	var date = new Date(), y = date.getFullYear();
	var date_from = new Date(y, 6, 30);
	var date_to = new Date(y, 7, 1);
	
  $('.datepicker').flatpickr({
	  dateFormat: "F j, Y",
    defaultDate: Date.now()
	});
  $('.datepickFrom').flatpickr({
	  dateFormat: "F j, Y",
    defaultDate: date_from
	});
  $('.datepickTo').flatpickr({
	  dateFormat: "F j, Y",
    defaultDate: date_to
	});
});

$( document ).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip()
})
$( document ).on('turbolinks:load', function() {
  $('[data-toggle="popover"]').popover()
})

$(document).on('turbolinks:load', function() {
	$('refresh_autonumeric').trigger()
})

