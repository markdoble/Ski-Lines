require 'open-uri'
require 'nokogiri'


# cera Nova wax
begin
  url = "http://www.swixsport.com/Products/Wax-Tuning/Glider/Cera-Nova-X"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".productlinebox .productwrapper").each do |i|
      begin
        location = i.at_css("h3 a")[:href].prepend("http://www.swixsport.com")
        name = i.at_css("h3 a").content
        sku = Nokogiri::HTML(open(location)).at_css(".productnumber").content.strip.sub(/Product number:/, '').strip
        image = Nokogiri::HTML(open(location)).at_css(".modelimagelarge img")['src'].prepend("http://www.swixsport.com")
        description = Nokogiri::HTML(open(location)).at_css(".intro").content.strip
      rescue
        next
      end
    next unless name && sku && image && description

    stock_product = Stockproduct.find_or_create_by(name: name) do |product|
      product.sku = sku
      product.description = description
      product.name = name
      product.brand = "Swix"
      product.ca_status = false
      product.us_status = false 
      end
    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    end
end
