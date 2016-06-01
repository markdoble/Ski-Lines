xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ski-Lines.com"
    xml.link "http://www.ski-lines.com"

    for article in @articles_rss
      xml.item do
        xml.title article.title
        xml.description article.description
        xml.pubDate article.date_published
        xml.link "http://www.ski-lines.com"
        xml.guid "http://www.ski-lines.com"
      end
    end
  end
end