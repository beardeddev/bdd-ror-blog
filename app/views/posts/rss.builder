xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Блог beardeddev.pp.ua"
    xml.description "Блог о программировании и не только"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.description
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end