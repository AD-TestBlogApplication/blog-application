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

  // fix main menu to page on passing
  $('#main-navigation').visibility({
    type: 'fixed',
    once: true,
    initialCheck: false
  });

  // lazy load images
  $('.image').visibility({
    type: 'image',
    transition: 'vertical flip in',
    duration: 500
  });

  // show dropdown on hover
  $('.main.menu  .ui.dropdown').dropdown({
    on: 'hover'
  });

  // modal
  $('.modal').modal('setting', 'transition', 'vertical flip')

  $('.modal-trigger').each(function() {
    $(this).on("click", function() {
      $(this.dataset.modalTarget).modal('show')
    });
  });
});
