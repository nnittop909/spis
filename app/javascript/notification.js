$(document).ready(function() {
  $('#notification').fadeIn( "drop", { direction: "down" }, function(){
    setTimeout(function() {
      $('#notification').fadeOut("slow",function(){
        $(this).remove();
      });
    }, 10000);
  });
  
});