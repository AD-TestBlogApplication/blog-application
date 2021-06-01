document.addEventListener("turbolinks:load", function() {
  require("semantic-ui-sass")

  // Messages
  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .transition('fade')
      ;
    })
  ;
});
