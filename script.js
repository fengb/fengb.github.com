(function($) {
  $('span.email').each(function(i, e) {
    var email = $(e).text().replace(/ \(dot\) /g, '.').replace(/ \(at\) /, '@');
    $(e).replaceWith('<a class="email" href="mailto:' + email + '">' + email + '</a>');
  });
})(jQuery)
