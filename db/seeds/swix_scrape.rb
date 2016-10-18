require 'open-uri'
require 'nokogiri'

begin
  url = "http://www.swixsport.com/Products/Wax-Tuning/Accessories2"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Wax-Tuning/Backshop-Program"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Wax-Tuning/Removers-Care-Products2"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Wax-Tuning/Removers-Care-Products2"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Jackets-Vests"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Mid-Layer"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Pants"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Bodywear"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Hats-Headbands"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Gloves-Mittens"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'n/a',
      quantity: 5,
      colour: 'n/a'
    )
    end
end


begin
  url = "http://www.swixsport.com/Products/Apparel/Racing-Suits"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Tights-Shorts"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/T-shirts"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XS',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'M',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XL',
      quantity: 5,
      colour: 'n/a'
    )
    end
end

begin
  url = "http://www.swixsport.com/Products/Apparel/Socks"
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
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: '37-39',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: '40-42',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: '43-45',
      quantity: 5,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: '46-48',
      quantity: 5,
      colour: 'n/a'
    )
    end
end
