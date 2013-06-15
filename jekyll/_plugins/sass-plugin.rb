module Jekyll
  # Sass plugin to convert .scss to .css
  #
  class SassConverter < Converter
    require 'sass'

    safe true
    priority :high

    def matches(ext)
      ext =~ /#{sass_config[:syntax]}/i
    end

    def output_ext(ext)
      ".css"
    end

    def sass_config
      if @sass_config.nil?
        @sass_config = {:syntax => :scss}
        (@config['sass'] || {}).each do |key, value|
          @sass_config[key.to_sym] = value
        end
      end
      @sass_config
    end

    def convert(content)
      begin
        Sass::Engine.new(content, sass_config).render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end
end
