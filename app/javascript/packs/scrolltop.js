$(document).on('turbolinks:load', function() {
  // 初期状態でボタンを隠す
  $('#back a').hide();

  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      $('#back a').fadeIn();
    } else {
      $('#back a').fadeOut();
    }
  });

  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 1000);
    event.preventDefault();
  });
});
