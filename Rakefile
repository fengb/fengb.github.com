WORK = '_site'

desc 'Remove generated files'
task :clean do
  rm_r WORK
end

desc 'Add metadata and compress images'
task :process_images do
  require 'rubygems'
  require 'oily_png'
  require 'chunky_png'

  Dir['*.png'].each do |f|
    img = ChunkyPNG::Image.from_file(f)
    img.metadata = {'license' => 'http://creativecommons.org/licenses/by-nc-nd/3.0/',
                    'attributionURL' => 'http://fengb.github.com/',
                    'attributionName' => 'Benjamin Feng'}
    img.save(f)
    sh "pngcrush -ow #{f}"
  end
end

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
