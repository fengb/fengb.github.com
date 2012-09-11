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

    def convert(content)
      begin
        puts "Performing Sass Conversion."
        engine = Sass::Engine.new(content, :syntax => :scss, :load_paths => ["."])
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end
end
