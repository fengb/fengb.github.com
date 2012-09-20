(function($) {
  var $contact = $('<nav id="contact"/>').insertAfter('article#main');
  $.get('/contact.html', function(data) {
      /* FIXME: regex should not parse HTML! */
      $contact.html(data.replace(/^[\s\S]*?<article[^>]*>\s*([\s\S]*)\s*<\/article>[\s\S]*?$/, '$1'));
  });

  Mutiny.init();
})(jQuery)
