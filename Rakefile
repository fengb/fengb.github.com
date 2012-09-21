# Copyright (C) 2012 Benjamin Feng
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


WORK = '_site'
DEFAULT_DPI = 110

desc 'Remove generated files'
task :clean do
  rm_r WORK
end

namespace :image do
  require 'rubygems'
  begin
    require 'oily_png'
  rescue LoadError
    require 'chunky_png'
  end

  desc 'Add metadata and compress images'
  task :process do
    force = ENV['force'] || false

    Dir['*.png'].each do |f|
      next if f =~ /thumb.png$/

      img = ChunkyPNG::Image.from_file(f)
      if img.metadata['Author'] != 'Benjamin Feng' or force
        img.metadata = {'License' => 'http://creativecommons.org/licenses/by-nc-nd/3.0/',
                        'Url' => 'http://fengb.github.com/',
                        'Author' => 'Benjamin Feng'}

        img.save(f)
        dpi = [DEFAULT_DPI, (DEFAULT_DPI.to_f * img.height / 750).round].max
        sh "pngcrush -res #{dpi} -ow #{f}"
      end
    end
  end

  desc 'Generate thumbnails'
  task :thumb do
    force = ENV['force'] || false

    Dir['*.png'].each do |f|
      next if f =~ /thumb.png$/

      target = f.sub('.png', '-thumb.png')
      if not File.exist?(target) or force
        img = ChunkyPNG::Image.from_file(f)

        height = 100
        width = (img.width.to_f / img.height * height).round
        img = img.resample_nearest_neighbor(width, height)

        img.save(target)
        sh "pngcrush -res #{DEFAULT_DPI} -ow #{target}"
      end
    end
  end
end
task :image => %w[image:process image:thumb]

desc 'Compile all assets for deployment'
task :compile do
  sh 'jekyll'
end

desc 'Stage assets to a fresh branch for publication'
task :stage => :compile do
  cd WORK do
    sh 'git init'
    sh 'git add .'
    sh 'git commit -m "AUTO PUBLISH"'
  end
end

desc 'Publish changes'
task :publish => :stage do
  url = `git remote show -n origin | sed -e '/Fetch URL/!d' -e 's/ *Fetch URL: //'`
  cd WORK do
    sh "git remote add origin #{url}"
    sh "git push -f origin master"
  end
end

desc 'Run the local web server'
task :server do
  sh 'jekyll --server --auto'
end

task :default => :compile
