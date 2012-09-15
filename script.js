(function($) {
  if($('article#main.contact').length === 0) {
    var $contact = $('<aside id="contact" />').insertBefore('footer#copy');
    $.ajax('/contact.html', {
      'success':function(data) {
        /* FIXME: regex should not parse HTML! */
        $contact.html(data.replace(/[\s\S]*<article.*>([\s\S]*)<\/article>[\s\S]*/, '$1'));
      }
    });
    $('nav#site .contact').remove();
    $('<a href="#">C</span>').appendTo('nav#site').click(function(evt) {
      var $toggle = $(evt.target);
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
