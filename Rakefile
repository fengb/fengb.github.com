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
  require 'tmpdir'
  branch = `git branch | sed -e '/^[^*]/d' -e 's/[*] //'`
  begin
    Dir.mktmpdir do |dir|
      mv WORK, dir
      sh "git branch -D #{WORK}" rescue nil
      sh "git checkout --orphan #{WORK}"
      sh 'git rm -rf .'
      sh 'git clean -f'
      Dir[File.join(dir, WORK, '*')].each do |file|
        mv file, pwd
      end
      sh 'git add .'
      sh 'git commit -m "AUTO PUBLISH"'
    end
  ensure
    sh "git checkout #{branch}"
  end
end

desc 'Run the local web server'
task :server do
  sh 'jekyll --server'
end

task :default => :compile
