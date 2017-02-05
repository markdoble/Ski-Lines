

$(document).ready(function(){
  if ($('.wow').length){
    new WOW().init();
  }
  
  if( $('.list-grid-toggler').length ) {
    $('.list-grid-toggler > a').on('click', function(e){
      e.preventDefault();

      if( !$(this).hasClass('disabled') ) {
        $('.products-list').toggleClass('list-view');

        $('.list-grid-toggler > a').removeClass('disabled');
        $(this).addClass('disabled');
      }
    });
  }


  if( $('#carousel-product-thumbs').length ) {
    $('#carousel-product-thumbs ul li').on('click', function () {
      var $that = $(this);
      var originalImage = $that.data('original');
      $('#carousel-product-thumbs li').removeClass('active');
      $('#carousel-product-original img').attr('src',originalImage);
      $that.addClass('active');
    });
  }

  if( $('#home-page-header').length ) {

    var $header = $('#home-page-header');
    var $nav = $('#nav');

    $(window).scroll(function() {
      var scroll = $(window).scrollTop();

      if (scroll >= 100) {
        $header.addClass('scrolled');
      } else {
        $header.removeClass('scrolled');
      }

      if (scroll >= 500) {
        $nav.addClass('scrolled');
      } else {
        $nav.removeClass('scrolled');
      }
    }).scroll();


  }
});
