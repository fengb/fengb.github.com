(function($) {
  Mutiny.init();

  /* On document.ready to let browsers report load completion */
  $(document).ready(function() {
    $('body#portfolio [href$=png]').each(function(i, e) {
      var img = new Image();
      img.src = e.href;
    });
  });
})(jQuery);
