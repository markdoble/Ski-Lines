module Admin::ProductsHelper

    def build_productfotos(product)
      times_build = 6 - product.productfotos.count
      times_build.times {@product.productfotos.build}
    end

    def build_product_units(product)
      unless product.units.count > 1
        times_build = 1 - product.units.count
        times_build.times {@product.units.build}
      end
    end

    def check_if_attributes_missing(product, total_units)
      # return true if all attributes are true
      if create_key_attributes_array(product, total_units).any?{ |m| m == false }
        false
      else
        true
      end
    end

    def missing_attributes(product, total_units)
      case create_key_attributes_array(product, total_units)
      when [true, true, false]
        "You must have a price listed in either USD or CAD, or both, before you can begin selling this product. Click Edit Product below to add a price."
      when [true, false, true]
        "You must have available inventory listed before you can start selling this product. Click Add Inventory above to list your available inventory."
      when [false, true, true]
        "You must add a photo to this product before you can start selling. Click Edit Product below to add a photo."
      when [true, false, false]
        "You must have inventory listed and a price before you can start selling this product. Click Add Inventory above to list your inventory, and click Edit Product below to add a price."
      when [false, true, false]
        "You must have a photo and a price listed before you can start selling this product. Click Edit Product below to add a photo and a price."
      when [false, false, true]
        "You must have a photo and available inventory before you can start selling this product. Click Edit Product below to add a photo, and Add Inventory above to list your available inventory."
      when [false, false, false]
        "You must have a photo, a price, and availalbe inventory listed before you can start selling this product. Click Edit Product below to add a photo and price, and Add Inventory above to list your available inventory."
      else
        "You must have a photo, a price, and availalbe inventory listed before you can start selling this product. Click Edit Product below to add a photo and price, and Add Inventory above to list your available inventory."
      end
    end

    def create_key_attributes_array(product, total_units)
      # if_this_is_a_true_value ? then_the_result_is_this : else_it_is_this
      # if the product has a photo, then make photo_present true
      ( product.photo.blank? && product.stockphoto.blank?) ? photo_present = false : photo_present = true
      # check if units are present
      total_units != 0 ? units_present = true : units_present = false
      # check if canadian price
      (!product.cad_price.nil? && product.cad_price > 0) ? cad_price_present = true : cad_price_present = false
      # check if american price
      (!product.usd_price.nil? && product.usd_price > 0) ? usd_price_present = true : usd_price_present = false
      # check if any price
      (cad_price_present == false && usd_price_present == false) ? price_present = false : price_present = true
      # make array of boolean values
      [photo_present, units_present, price_present]
    end

end
