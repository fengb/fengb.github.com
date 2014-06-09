activate :blog, layout: 'blog', prefix: 'blog', summary_separator: /\n\n/

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'
set :fonts_dir,  'fonts'
set :site_url,   'http://www.fengb.info'

helpers do
  def title
    segments = ['fengb.info', current_page.data[:title]]
    segments.compact.join(' &rarr; ')
  end

  def main_class
    if current_page.data[:class]
      "p-#{current_page.data[:class]}"
    else
      "p-#{current_page.data[:title].to_s.dasherize.downcase}"
    end
  end
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
