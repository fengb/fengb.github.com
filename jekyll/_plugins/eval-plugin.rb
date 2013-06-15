module Jekyll
  class EvalConverter < Converter
    safe true
    priority :high

    def matches(ext)
      ext =~ /.eval$/i
    end

    def output_ext(ext)
      ext.gsub /.eval$/i, ''
    end

    def convert(content)
      eval(content)
    end
  end
end
