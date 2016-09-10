require 'open-uri'
require 'nokogiri'
EasyTranslate.api_key = ENV['GOOGLE_API_KEY']

=begin
=end




# neveitalia.it/sport/scinordico/
begin
  url = "http://www.neveitalia.it/sport/scinordico/"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else

    doc.css(".art-preview-bottom .art-preview-wrapper .art-preview").each do |i|
      begin
        title_ita = i.at_css("h3 a")
        location = i.at_css("h3 a")[:href].prepend("http://www.neveitalia.it")
        image = i.at_css(".boxarticolofoto a img")[:src]
        description_ita = i.at_css("p")
      rescue
        next
      end
    next unless title_ita && location && description_ita && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_ita.content, :to => :english)
      article.description = EasyTranslate.translate(description_ita.content, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "neveitalia.it"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
      end
    end

end



#fasterskier
begin
    url = "http://fasterskier.com"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".hfeed .article").each do |i|
      begin
        location = i.at_css(".entry-title a")[:href]
        title = i.at_css(".entry-title a")
        description = i.at_css(".entry-content p")
        if img = i.at_css(".entry-content img")
          image = img['src']
        else
          image = "american_flag.png"
        end
      rescue
        next
      end
    next unless title && location && description && image

    Article.find_or_create_by(location: location) do |article|
      article.title = title.content
      article.description = description.content
      article.date_published = Time.zone.now.to_date
      article.category = "Cross Country"
      article.source = "fasterskier.com"
      article.notes = ""
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

#CCCSki
begin
    url = "http://www.cccski.com/Special-Pages/News-Archives.aspx"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".newsList li").each do |i|
      begin
        location = i.at_css("h4 a")[:href].prepend("http://www.cccski.com")
        title = i.at_css("h4 a")
        description = i.at_css(".description")
      rescue
        next
      end
    next unless title && location && description

    Article.find_or_create_by(location: location) do |article|
      article.category = "Cross Country"
      article.title = title.content
      article.description = description.content
      article.date_published = Time.zone.now.to_date
      article.source = "cccski.com"
      article.notes = ""
      article.image = "can_flag.png"
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

#FIS
begin
    url = "http://www.fis-ski.com/cross-country//news-multimedia/news/"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".dcm-newsList li").each do |i|
      begin
        location = i.at_css(".dcm-news .dcm-title a")[:href].prepend("http://www.fis-ski.com")
        title = i.at_css(".dcm-news .dcm-title a")
        description = i.at_css(".dcm-news .dcm-summary")
      rescue
        next
      end
    next unless title && location && description

    Article.find_or_create_by(location: location) do |article|
      article.category = "Cross Country"
      article.title = title.content
      article.description = description.content
      article.date_published = Time.zone.now.to_date
      article.source = "fis-ski.com"
      article.notes = ""
      article.image = "fis_brand.png"
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

#nordic.usskiteam.com
begin
    url = "http://nordic.usskiteam.com/news/all/nordic"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".views-field-title").each do |i|
      begin
        location = i.at_css("a")
        title = i.at_css("a")
        description = i.at_css("span p")
      rescue
        next
      end
    next unless title && location && description

    Article.find_or_create_by(location: location[:href].prepend("http://nordic.usskiteam.com")) do |article|
      article.category = "Cross Country"
      article.title = title.content
      article.description = description.content
      article.date_published = Time.zone.now.to_date
      article.source = "usskiteam.com"
      article.notes = ""
      article.image = "american_flag.png"
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

#Langrenn
begin
    url = "http://www.langrenn.com/index.php?cat=229037"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".artikkelarkiv .artarchiverow").each do |i|
      begin
        location = i.at_css(".artarchivetitle .headlinelinkarchive .headlinelinkarchive")[:href].prepend("http://www.langrenn.com/")
        description_nor = Nokogiri::HTML(open(location)).at_css(".ingressview p")
        title_nor = i.at_css(".artarchivetitle .headlinelinkarchive .headlinelinkarchive")
        if img = Nokogiri::HTML(open(location)).at_css(".imgwithtext a img")
          image = img['src']
         else
          image = "norway_flag.png"
        end
      rescue
        next
      end
    next unless title_nor && location && description_nor && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_nor.content, :to => :english)
      article.description = EasyTranslate.translate(description_nor.content, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "langrenn.com"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

#skisport.ru Russian Site
begin
    url = "http://skisport.ru"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".news-grid .column-row .column-wrap-left .news-item").each do |i|
      begin
        location = i.at_css(".news-text h2 a")[:href].prepend("http://skisport.ru")
        title_rus = i.at_css(".news-text h2")
        description_rus = i.at_css(".news-text p")
        if img = i.at_css(".news-text img")
          image = img['src'].prepend("http://skisport.ru")
        else
          image = "russian_flag.png"
        end
      rescue
        next
      end
    next unless title_rus && location && description_rus && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_rus.content, :to => :english)
      article.description = EasyTranslate.translate(description_rus.content, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "skisport.ru"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# www.kestavyysurheilu.fi
begin
    url = "http://www.kestavyysurheilu.fi/hiihto"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".items-row").each do |i|
      begin
        location = URI.escape(i.at_css(".item h2 a")[:href].prepend("http://kestavyysurheilu.fi"))
        title_fin = i.at_css(".item h2 a").content.gsub(/[[:space:]]/, ' ').strip
        description_fin = Nokogiri::HTML(open(location)).at_css(".item-page > p").content
        if img = i.at_css(".item .blog-image a img")
          image = URI.escape(img['src'].prepend("http://kestavyysurheilu.fi"))
        else
          image = "fin_flag.png"
        end
      rescue
        next
      end
    next unless title_fin && location && description_fin && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_fin, :to => :english)
      article.description = EasyTranslate.translate(description_fin, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "kestavyysurheilu.fi"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# ski-nordique.net block21
begin
    url = "http://www.ski-nordique.net/ski-de-fond.138912.fr.html"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".block21").each do |i|
      begin
        location = i.at_css(".headline .headlinelink")[:href].prepend("http://www.ski-nordique.net")
        title_fr = i.at_css(".link")['title']
        description_fr = i.at_css(".ingress p")
        image = "french_flag.png"
      rescue
        next
      end
    next unless title_fr && location && description_fr && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_fr, :to => :english)
      article.description = EasyTranslate.translate(description_fr.content, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "ski-nordique.net"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
     end
     end
end

# ski-nordique.net block22
begin
    url = "http://www.ski-nordique.net/ski-de-fond.138912.fr.html"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".block22").each do |i|
      begin
        location = i.at_css(".headline .headlinelink")[:href].prepend("http://www.ski-nordique.net")
        title_fr = i.at_css(".link")['title']
        description_fr = i.at_css(".ingress p")
        image = "french_flag.png"
      rescue
        next
      end
    next unless title_fr && location && description_fr && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_fr, :to => :english)
      article.description = EasyTranslate.translate(description_fr.content, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "ski-nordique.net"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# langd.se block 21
begin
    url = "http://www.langd.se"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".block21").each do |i|
      begin
        location = i.at_css(".headline .headlinelink")[:href].prepend("http://www.langd.se")
        title_sw = doc.fragment(i.at_css(".headline .headlinelink")).content.encode("iso-8859-1")
        description_sw = doc.fragment(i.at_css(".ingress p")).content.force_encoding("utf-8")
        image = URI.escape(i.at_css(".linkimage img")['src'])
      rescue
        next
      end
    next unless title_sw && location && description_sw && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_sw, :to => :english)
      article.description = EasyTranslate.translate(description_sw, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "langd.se"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end


# langd.se block 22
begin
    url = "http://www.langd.se"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".block22").each do |i|
      begin
        location = i.at_css(".headline .headlinelink")[:href].prepend("http://www.langd.se")
        title_sw = doc.fragment(i.at_css(".headline .headlinelink")).content.encode("iso-8859-1")
        description_sw = doc.fragment(i.at_css(".ingress p")).content.force_encoding("utf-8")
        image = URI.escape(i.at_css(".linkimage img")['src'])
      rescue
        next
      end
    next unless title_sw && location && description_sw && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_sw, :to => :english)
      article.description = EasyTranslate.translate(description_sw, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "langd.se"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end


#adressa.no
begin
    url = "http://www.adressa.no/100Sport/langrenn/"
    doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".gridRow .gridUnit .widget .article").each do |i|
      begin
        title_norw = i.at_css(".inner .text .headline .t100")
        location = i.at_css("a")[:href]
        image = i.at_css(".media a img")[:src]
        description_norw = Nokogiri::HTML(open(URI.escape(location))).at_css(".body p")
      rescue
        next
      end
    next unless title_norw && location && description_norw && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_norw.content, :to => :english)
      article.description = EasyTranslate.translate(description_norw.content, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "adressa.no"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end



#xc-ski.de
begin
    url = "http://www.xc-ski.de/352--news.html"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".row-fluid .column_container .td_mod9").each do |i|
      begin
        location = i.at_css(".item-details .more-link-wrap a")[:href]
        description_ger = i.at_css(".item-details .td-post-text-excerpt").content
        title_ger = i.at_css(".item-details .entry-title").content
        image = i.at_css(".thumb-wrap a img")[:src]
      rescue
        next
      end
    next unless title_ger && location && description_ger && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_ger, :to => :english)
      article.description = EasyTranslate.translate(description_ger, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "xc-ski.de"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end


# Skitime.it cross-country
begin
    url = "http://skitime.it/index.php/news/sci-di-fondo"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".itemList div .itemContainer").each do |i|
      begin
        location = i.at_css("article.itemView header h1 a")[:href].prepend("http://www.skitime.it")
        description_ita = Nokogiri::HTML(open(URI.escape(location))).at_css(".itemBody .itemFullText").content
        title_ita = i.at_css("article.itemView header h1 a").content
        if img = i.at_css("article.itemView .itemBlock .itemImageBlock a img")
          image = URI.escape(img[:src].prepend("http://www.skitime.it"))
        else
          image = "ita_flag.jpg"
        end
      rescue
        next
      end
    next unless title_ita && location && description_ita && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_ita, :to => :english)
      article.description = EasyTranslate.translate(description_ita, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "skitime.it"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# nflg.kz cross-country
begin
    url = "http://nflg.kz"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".products-holder").each do |i|
      begin
        location = i.at_css(".small-header-text-container .small-header-text a")[:href]
        description_kaz = i.at_css(".details-area p").content
        title_kaz = i.at_css(".small-header-text-container .small-header-text a").content
        image = i.at_css(".full-img-column .gallery-view img")[:src]
      rescue
        next
      end
    next unless title_kaz && location && description_kaz && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_kaz, :to => :english)
      article.description = EasyTranslate.translate(description_kaz, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "nflg.kz"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# bezkuj.com/clanky - top article
begin
    url = "https://www.bezkuj.com/clanky"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".article-top .perex").each do |i|
      begin
        location = i.at_css(".content-header h1 a")[:href].prepend("https://www.bezkuj.com")
        description_cze = i.at_css(".text p").content
        title_cze = i.at_css(".content-header h1 a").content
        image = i.at_css(".flt img")[:src]
      rescue
        next
      end
    next unless title_cze && location && description_cze && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_cze, :to => :english)
      article.description = EasyTranslate.translate(description_cze, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "bezkuj.com"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end


# bezkuj.com/clanky - list of articles article
begin
    url = "https://www.bezkuj.com/clanky"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".articles-col2 .content-articles .perex").each do |i|
      begin
        location = i.at_css("a")[:href].prepend("https://www.bezkuj.com")
        description_cze = i.at_css(".text p").content
        title_cze = i.at_css("h2 a").content
        image = i.at_css("a img")[:src]
      rescue
        next
      end
    next unless title_cze && location && description_cze && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_cze, :to => :english)
      article.description = EasyTranslate.translate(description_cze, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "bezkuj.com"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# http://nationalnordicfoundation.org
begin
    url = "http://nationalnordicfoundation.org"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".content-wrapper .container .row .col-sm-12 .row .col-sm-6 .thumbnail").each do |i|
      begin
        location = i.at_css("a")[:href]
        description = Nokogiri::HTML(open(URI.escape(location))).at_css(".row .col-sm-8").content
        title = i.at_css("a .caption h3").content
        image = i.at_css("a img")[:src]
      rescue
        next
      end
    next unless title && location && description && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = title
      article.description = description
      article.date_published = Time.zone.now.to_date
      article.source = "nationalnordicfoundation.org"
      article.notes = ""
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end


# skidzonen.se/category/langdakning/
begin
    url = "http://skidzonen.se/category/langdakning/"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css(".td_block_inner .td-big-grid-wrapper .td-grid-columns .td-animation-stack").each do |i|
      begin
        location = i.at_css(".td-meta-info-container .td-meta-align .td-big-grid-meta h3 a")[:href]
        description_swe = Nokogiri::HTML(open(URI.escape(location))).at_css(".td-post-content p").content
        title_swe = i.at_css(".td-meta-info-container .td-meta-align .td-big-grid-meta h3 a").content
        image = i.at_css(".td-module-thumb a img")[:src]
      rescue
        next
      end
    next unless title_swe && location && description_swe && image

    Article.find_or_create_by(location: "#{location}") do |article|
      article.category = "Cross Country"
      article.title = EasyTranslate.translate(title_swe, :to => :english)
      article.description = EasyTranslate.translate(description_swe, :to => :english)
      article.date_published = Time.zone.now.to_date
      article.source = "skidzonen.se"
      article.notes = "Translated"
      article.image = image
      article.publish = "No"
      article.article_format = 'standard'
    end
    end
end

# Skitrax.com
begin
    url = "http://skitrax.com/"
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'UTF-8'
rescue OpenURI::HTTPError => e
else
    doc.css("#col_mid_home > .mid_box > .post-alt").each do |i|
      begin
        location = i.at_css("b a")[:href]
        description = Nokogiri::HTML(open(URI.escape(location))).at_css(".entry").content
        title = i.at_css("b a").content
        image = i.at_css(".home_thumb img")[:src]
      rescue
        next
      end
    next unless title && location && description && image

      Article.find_or_create_by(location: "#{location}") do |article|
        article.category = "Cross Country"
        article.title = title
        article.description = description
        article.date_published = Time.zone.now.to_date
        article.source = "skitrax.com"
        article.notes = ""
        article.image = image
        article.publish = "No"
        article.article_format = 'standard'
      end
    end
end
