require 'open-uri'
require 'nokogiri'

begin
  url = "http://www.startskiwax.com/en/skiwaxes/gliders"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".productContainerBlock .productOuterContent .productListBlock .productListBlockContent").each do |i|
      begin
        location = i.at_css(".productInfo .productPageLink a")[:href]
        name = i.at_css(".productNameContainer .productName span").content
        image = Nokogiri::HTML(open(location)).at_css(".product-thumb")['src'].prepend("http://www.startskiwax.com/")
        description = i.at_css(".productInfo p").content
        temperature = i.at_css(".productInfo .specs .temperature").content
        humidity = i.at_css(".productInfo .specs .humid").content
        size = i.at_css(".productInfo .specs .size").content
        sku = i.at_css(".productInfo .specs .product_productnumber").content
      rescue
        next
      end
    next unless name && sku && image && description

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description << "; " << "Temperature Range: " << temperature << "; Humidity: " << humidity
      product.name = name.sub(/Start /, '') << " " << size
      product.brand = "Start"
      product.ca_status = false
      product.us_status = false
      end
    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.startskiwax.com/en/skiwaxes/kick-waxes"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".productContainerBlock .productOuterContent .productListBlock .productListBlockContent").each do |i|
      begin
        location = i.at_css(".productInfo .productPageLink a")[:href]
        name = i.at_css(".productNameContainer .productName span").content
        image = Nokogiri::HTML(open(location)).at_css(".product-thumb")['src'].prepend("http://www.startskiwax.com/")
        description = i.at_css(".productInfo p").content
        temperature = i.at_css(".productInfo .specs .temperature").content

        size = i.at_css(".productInfo .specs .size").content
        sku = i.at_css(".productInfo .specs .product_productnumber").content
      rescue
        next
      end
    next unless name && sku && image && description

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description << "; " << "Temperature Range: " << temperature
      product.name = name.sub(/Start /, '') << " " << size
      product.brand = "Start"
      product.ca_status = false
      product.us_status = false
      end
    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end
