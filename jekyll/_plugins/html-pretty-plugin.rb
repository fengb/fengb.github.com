require 'html_pretty'


module Jekyll
  class Page
    alias_method :old_output, :output
    def output
      ext =~ /.html$/ ? ::HtmlPretty.run(old_output) : old_output
    end
  end
end
