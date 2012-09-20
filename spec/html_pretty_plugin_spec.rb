require '_plugins/html-pretty-plugin'

describe HtmlPretty do
  it 'parses simplest html block' do
    html = <<-END
<html>
</html>
    END

    output = HtmlPretty.fake_tidy(html)
    output.should == html
  end
end
