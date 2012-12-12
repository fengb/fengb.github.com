module Jekyll
  class WkhtmltopdfFile < Jekyll::StaticFile
    def initialize(site, base, dir, name)
      super
      @destname = name.gsub(/\.\w*/, '.pdf')
    end

    def write(dest)
      src_path = File.join(dest, @dir, @name)
      dest_path = File.join(dest, @dir, @destname)

      return false if File.exist?(dest_path) and !modified?
      @@mtimes[path] = mtime

      FileUtils.mkdir_p(File.dirname(dest_path))
      system("wkhtmltopdf --print-media-type #{src_path} #{dest_path}")
    end
  end

  class WkhtmltopdfGenerator < Generator
    def generate(site)
      site.pages.each do |page|
        if page.data['pdf']
          site.static_files << WkhtmltopdfFile.new(site, page.instance_variable_get(:@base), page.dir, page.name)
        end
      end
    end
  end
end
