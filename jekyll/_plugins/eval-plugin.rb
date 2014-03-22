module Jekyll
  class EvalConverter < Converter
    safe true
    priority :high

    def matches(ext)
      ext =~ /.rb$/i
    end

    def output_ext(ext)
      ext.gsub /.rb$/i, ''
    end

    def convert(content)
      eval(content)
    end
  end
end
