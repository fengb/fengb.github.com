(function($) {
  var $contact = $('<aside id="contact"/>').insertAfter('article#main');
  $.get('/contact.html', function(data) {
      /* FIXME: regex should not parse HTML! */
      $contact.html(data.replace(/^[\s\S]*?<article[^>]*>\s*([\s\S]*)\s*<\/article>[\s\S]*?$/, '$1'));
  });

  $('*').mutiny();

  /* On document.ready to let browsers report load completion */
  $(document).ready(function() {
    $('.portfolio [href$=png]').each(function(i, e) {
      var img = new Image();
      img.src = e.href;
    });
  });
})(jQuery)
