(function($) {
  var $contact = $('<nav id="contact"/>').insertAfter('article#main');
  $.get('/contact.html', function(data) {
      /* FIXME: regex should not parse HTML! */
      $contact.html(data.replace(/^[\s\S]*?<article[^>]*>\s*([\s\S]*)\s*<\/article>[\s\S]*?$/, '$1'));
  });

  var $toggle = $('[data-mutiny]');
  var $target = $($toggle.data('mutiny')['toggler']);
  $toggle.click(function() {
    if($toggle.hasClass('active')) {
      $toggle.removeClass('active').addClass('inactive');
      $target.removeClass('active').addClass('inactive');
    } else {
      $toggle.addClass('active').removeClass('inactive');
      $target.addClass('active').removeClass('inactive');
    }
    return false;
  });
})(jQuery)
