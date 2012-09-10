desc 'Remove generated files'
task :clean do
  rm_r '_site'
end

desc 'Compile all assets for deployment'
task :compile do
  sh 'jekyll'
end

desc 'Run the local web server'
task :server do
  sh 'jekyll --server'
end

task :default => :compile
