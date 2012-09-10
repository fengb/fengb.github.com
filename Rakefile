WORK = '_site'

desc 'Remove generated files'
task :clean do
  rm_r WORK
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
