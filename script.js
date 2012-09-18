(function($) {
  if($('article#main.contact').length === 0) {
    var $contact = $('<nav id="contact"/>').insertAfter('article#main');
    $.ajax('/contact.html', {
      'success':function(data) {
        /* FIXME: regex should not parse HTML! */
        data = data.replace(/^[\s\S]*?<article[^>]*>([\s\S]*)<\/article>[\s\S]*?$/, '$1');
        data = data.replace(/\s*<script[^>]*>[\s\S]*?<\/script>\s*/g, '')
        $contact.html(data);
      }
    });
    var $toggle = $('nav#site .contact a');
    $toggle.click(function() {
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
