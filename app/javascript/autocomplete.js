$(document).ready(function() {
	jQuery.railsAutocomplete.options.showNoMatches;
});
document.addEventListener("turbolinks:load", () => {
	$('.modal').on('shown.bs.modal', function () {
	  $('.datepicker-modal').datepicker({
	    format: "MM dd, yyyy",
	    orientation: "auto",
	    todayHighlight: 'true',
	    autoclose: 'true'
	  });
	});
});