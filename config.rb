require 'bundler'
Bundler.require

activate :blog, layout: 'blog_entry',
                prefix: 'blog',
                summary_separator: /\n\n/,
                tag_template: 'includes/tag.html'

set :css_dir,      'stylesheets'
set :js_dir,       'javascripts'
set :images_dir,   'images'
set :fonts_dir,    'fonts'
set :partials_dir, 'includes'

set :site_url,     'http://www.fengb.me'

helpers do
  def title
    segments = ['fengb.me', yield_content(:title), current_page.data[:title]]
    segments.compact.join(' &rarr; ')
  end

  def main_class
    if current_page.data[:class]
      "p-#{current_page.data[:class]}"
    else
      "p-#{current_page.data[:title].to_s.dasherize.downcase}"
    end
  end

  def strip_tags(str)
    str.gsub(/\<.*?\>/, '')
  end
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.branch = 'master'
end
