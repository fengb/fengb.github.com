require '_plugins/html-pretty-plugin'

require 'yaml'
data = YAML.load_file(__FILE__.sub(/rb$/, 'yaml'))

describe HtmlPretty do
  data.each do |context_name, tests|
    context context_name do
      tests.each do |test_name, config|
        it test_name do
          output = HtmlPretty.fake_tidy(config['in'])
          output.should == config['out'].sub(/\n$/, '')
        end
      end
    end
  end
end
