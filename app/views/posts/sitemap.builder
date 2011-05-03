xml.instruct!  
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @posts.each do |post|
    xml.url do
      xml.loc url_for :only_path => false, :controller => 'posts', :action => 'show', :id => "#{post.id}-#{post.title_transliterated}"
      xml.lastmod post.updated_at.strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end
  @pages.each do |page|
    xml.url do
      xml.loc url_for :only_path => false, :controller => 'pages', :action => 'show', :url => "#{page.url == '/' ? '' : page.url}"
      xml.lastmod page.updated_at.strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end
end
