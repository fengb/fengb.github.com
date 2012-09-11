# https://gist.github.com/960150

module Jekyll
  # Sass plugin to convert .scss to .css
  #
  # Note: This is configured to use the new css like syntax available in sass.
  class SassConverter < Converter
    require 'sass'

    safe true
    priority :high

    def matches(ext)
      ext =~ /scss/i
    end

    def output_ext(ext)
      ".css"
    end

    def sass_config
      if @sass_config.nil?
        @sass_config = {:syntax => :scss, :load_paths => ["."]}
        (@config['sass'] || {}).each do |key, value|
          @sass_config[key.to_sym] = value
        end
      end
      @sass_config
    end

    def convert(content)
      begin
        engine = Sass::Engine.new(content, sass_config)
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end
end
