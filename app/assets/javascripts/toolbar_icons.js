document.addEventListener("turbolinks:load", () => {
  $("button.bold").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-bold'></i>");
  $("button.italic").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-italic'></i>");
  $("button.strike").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-strikethrough'></i>");
  $("button.link").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-link'></i>");

  $("button.heading-1").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-heading'></i>");
  $("button.quote").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-quote-right'></i>");
  $("button.code").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-code'></i>");
  $("button.bullets").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-list-ul'></i>");
  $("button.numbers").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-list-ol'></i>");
  $("button.decrease").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-level-down-alt'></i>");
  $("button.increase").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-level-up-alt'></i>");

  $("button.undo").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-undo'></i>");
  $("button.redo").html("").addClass('btn btn-sm btn-outline-secondary').html("<i class='fa fa-redo'></i>");

});