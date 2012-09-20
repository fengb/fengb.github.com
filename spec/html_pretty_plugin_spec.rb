require '_plugins/html-pretty-plugin'

describe HtmlPretty do
  context 'single tags' do
    it 'parses simplest html block' do
      html = "<html></html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == html
    end

    it 'quashes beginning whitespace' do
      html = "       <html>\n\t</html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == "<html>\n</html>"
    end

    it 'quashes trailing whitespace' do
      html = "<html>      \n</html>\t"

      output = HtmlPretty.fake_tidy(html)
      output.should == "<html>\n</html>"
    end

    it 'collapses whitespace within tags' do
      html = "<html  \tfoo='bar'   tony='hawk'></html   >"

      output = HtmlPretty.fake_tidy(html)
      output.should == "<html foo='bar' tony='hawk'></html>"
    end

    it 'quashes whitespace at the tag extremes' do
      html = "<    html\t></html   >"

      output = HtmlPretty.fake_tidy(html)
      output.should == "<html></html>"
    end

    it 'quashes blank lines' do
      html = "<html>\n\n\n\n</html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == "<html>\n</html>"
    end

    it 'collapses spaces between tags' do
      # HTML text nodes have meanings so we can't just quash them.
      html = "<html> \t\t</html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == "<html> </html>"
    end
  end

  context 'nested tags' do
    it 'indents with outstanding opening tag' do
      html = "\
<html>
<hi>
</hi>
</html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == "\
<html>
  <hi>
  </hi>
</html>"
    end

    it 'indents with multiple opening tags' do
      html = "\
<html>
<hi>
<bye>
</bye>
</hi>
</html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == "\
<html>
  <hi>
    <bye>
    </bye>
  </hi>
</html>"
    end

    it 'does not indent further with self closing tags' do
      html = "\
<html>
<hi />
<bye />
</html>"

      output = HtmlPretty.fake_tidy(html)
      output.should == "\
<html>
  <hi />
  <bye />
</html>"
    end
  end

  context 'special tags' do
    it 'does not indent from <!DOCTYPE>' do
      html = "\
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html />"

      output = HtmlPretty.fake_tidy(html)
      output.should == html
    end
  end
end
