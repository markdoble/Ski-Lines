require 'open-uri'
require 'nokogiri'

# men's nordic tops
begin
  url = "http://shop.craftsports.us/men/nordic-ski.html?cat=98&limit=36"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Midlayers").first
      StockproductCategory.create(
        stockproduct_id: stock_product.id,
        category_id: product_category.id
      )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XX-Large',
      quantity: 1,
      colour: 'n/a'
    )
    end
end

# men's tights/pants
begin
  url = "http://shop.craftsports.us/men/nordic-ski.html?cat=100&limit=36"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      if stock_product.name.downcase.include?("pant")
        product_category = Category.where(parent_id: parent_category.id, name: "Training Pants").first
      elsif stock_product.name.downcase.include?("tight")
        product_category = Category.where(parent_id: parent_category.id, name: "Tights").first
      end

      StockproductCategory.create(
        stockproduct_id: stock_product.id,
        category_id: product_category.id
      )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XX-Large',
      quantity: 1,
      colour: 'n/a'
    )
    end
end

# men's jackets
begin
  url = "http://shop.craftsports.us/men/nordic-ski.html?cat=102&limit=36"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      if stock_product.name.downcase.include?("vest")
        product_category = Category.where(parent_id: parent_category.id, name: "Training Vest").first
      else
        product_category = Category.where(parent_id: parent_category.id, name: "Training Jacket").first
      end
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XX-Large',
      quantity: 1,
      colour: 'n/a'
    )
    end
end



# hats
begin
  url = "http://shop.craftsports.us/men/nordic-ski.html?cat=108&limit=36"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end


    product_category = Category.where(name: "Hats and Toques").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'L/XL',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'S/M',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# gloves
begin
  url = "http://shop.craftsports.us/men/nordic-ski.html?cat=110&limit=36"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end


    product_category = Category.where(name: "Gloves & Mitts").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end



# Women's

# Wommen's nordic tops
begin
  url = "http://shop.craftsports.us/women/nordic-ski.html?cat=99"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      if stock_product.name.downcase.include?("jacket")
        product_category = Category.where(parent_id: parent_category.id, name: "Training Jacket").first
      else
        product_category = Category.where(parent_id: parent_category.id, name: "Midlayers").first
      end
      StockproductCategory.create(
        stockproduct_id: stock_product.id,
        category_id: product_category.id
      )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XX-Large',
      quantity: 1,
      colour: 'n/a'
    )
    end
end



# Women's tights/pants
begin
  url = "http://shop.craftsports.us/women/nordic-ski.html?cat=101"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      if stock_product.name.downcase.include?("pant")
        product_category = Category.where(parent_id: parent_category.id, name: "Training Pants").first
      elsif stock_product.name.downcase.include?("tight")
        product_category = Category.where(parent_id: parent_category.id, name: "Tights").first
      else
        product_category = Category.where(parent_id: parent_category.id, name: "Training Pants").first
      end

      StockproductCategory.create(
        stockproduct_id: stock_product.id,
        category_id: product_category.id
      )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XX-Large',
      quantity: 1,
      colour: 'n/a'
    )
    end
end

# Women's jackets
begin
  url = "http://shop.craftsports.us/men/nordic-ski.html?cat=102&limit=36"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      if stock_product.name.downcase.include?("vest")
        product_category = Category.where(parent_id: parent_category.id, name: "Training Vest").first
      else
        product_category = Category.where(parent_id: parent_category.id, name: "Training Jacket").first
      end
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'XX-Large',
      quantity: 1,
      colour: 'n/a'
    )
    end
end


# Men's Baselayers
# stay cool
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=27"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Be active
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=29"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# keep warm
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=37"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )

    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# long sleeve
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=41"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Short sleeve
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=43"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Shorts
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=45"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Long underwear
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=47"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Long gundes
begin
  url = "http://shop.craftsports.us/men/baselayer.html?cat=49"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Men's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end






# Women's Baselayers
# stay cool
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=28"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Be active
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=30"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# keep warm
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=38"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )

    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# long sleeve
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=42"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Short sleeve
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=44"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end


# Underwear
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=48"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end

# Bras
begin
  url = "http://shop.craftsports.us/women/baselayer.html?cat=129"
  doc = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError => e
else
    doc.css(".products-grid .item").each do |i|
      begin
        location = i.at_css(".product-info .product-name a")[:href]
        name = i.at_css(".product-info .product-name a").content
        image = Nokogiri::HTML(open(location)).at_css(".left-content .product-image-gallery .gallery-image")[:src]
        description = Nokogiri::HTML(open(location)).at_css(".left-content .stinno-proddetails").content
        sku = Nokogiri::HTML(open(location)).at_css(".stinno-prodsku").content.tr("SKU#", "").strip
        usd_msrp = i.at_css(".product-info .price-box .regular-price .price").content.tr("$", "")
      rescue
        next
      end
    next unless name && sku && image && description && location && usd_msrp
    next unless !Stockproduct.where(brand: "Craft").include?(sku: sku)

    stock_product = Stockproduct.find_or_create_by(sku: sku) do |product|
      product.description = description.strip
      product.name = name
      product.brand = "Craft"
      product.ca_status = false
      product.us_status = false
      product.usd_msrp = usd_msrp
      end

      parent_category = Category.find_by_name("Women's Clothing")
      product_category = Category.where(parent_id: parent_category.id, name: "Baselayer").first
    StockproductCategory.create(
      stockproduct_id: stock_product.id,
      category_id: product_category.id
    )

    Stockphoto.create(
      photo: open(image),
      stockproduct_id: stock_product.id
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Small',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Medium',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'Large',
      quantity: 1,
      colour: 'n/a'
    )
    Stockunit.create(
      stockproduct_id: stock_product.id,
      size: 'X-Large',
      quantity: 1,
      colour: 'n/a'
    )

    end
end
