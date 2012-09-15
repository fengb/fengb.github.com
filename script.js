(function($) {
  if($('article#main.contact').length === 0) {
    var $contact = $('aside#contact');
    $.ajax('/contact.html', {
      'success':function(data) {
        /* FIXME: regex should not parse HTML! */
        $contact.html(data.replace(/[\s\S]*<article.*>([\s\S]*)<\/article>[\s\S]*/, '$1'));
      }
    });
    var $toggle = $('nav#site a.toggle-contact');
    $toggle.click(function(evt) {
      if($toggle.hasClass('active')) {
        $toggle.removeClass('active');
        $contact.removeClass('active');
      } else {
        $toggle.addClass('active');
        $contact.addClass('active');
      }
      return false;
    });
  }
})(jQuery)
