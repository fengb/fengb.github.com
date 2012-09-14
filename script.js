(function($) {
  $.ajax('/contact.html', {
    'success':function(data) {
      /* FIXME: regex should not parse HTML! */
      $('<aside id="contact" />').insertBefore('footer#copy')
                                 .append(data.replace(/[\s\S]*<article.*>([\s\S]*)<\/article>[\s\S]*/, '$1'));
    }
  });
})(jQuery)
