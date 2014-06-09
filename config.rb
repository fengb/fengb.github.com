activate :blog, layout: 'blog', prefix: 'blog', summary_separator: /\n\n/

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'
set :fonts_dir,  'fonts'

helpers do
  def title
    segments = ['fengb.info', current_page.data[:title]]
    segments.compact.join(' &rarr; ')
  end

  def main_class
    if current_page.data[:class]
      "p-#{current_page.data[:class]}"
    else
      "p-#{current_page.data[:title].dasherize.downcase}"
    end
  end
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
