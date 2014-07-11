---
layout: false
---
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'fengb.info'
    xml.link settings.site_url
    xml.description 'RSS feed for fengb.info'
    xml.link href: "#{settings.site_url}/rss.xml", rel: 'self', type: 'application/rss+xml', xmlns: 'http://www.w3.org/2005/Atom'

    blog.articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description strip_tags(article.summary)
        xml.pubDate article.date.strftime('%a, %d %b %Y %H:%M:%S %z')
        xml.link "#{settings.site_url}#{article.url}"
        xml.guid "#{settings.site_url}#{article.url}", isPermaLink: true
      end
    end
  end
end
