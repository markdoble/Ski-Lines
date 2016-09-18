/*
 * Function to be executed once the DOM has been fully loaded and ready
 */
$(document).ready(function() {
	// GST and PST provinces
	var albertaGST = 0.05;
	var albertaPST = 0;
	var bcGST = 0.05;
	var bcPST = 0.07;
	var manitobaGST = 0.05;
	var manitobaPST = 0.08;
	var quebecGST = 0.05;
	var quebecPST = 0.0975;
	var saskGST = 0.05;
	var saskPST = 0.05;
	// HST provinces
	var newbrunswickHST = 0.13;
	var nfldandlabradorHST = 0.13;
	var novaScotiaHST = 0.15;
	var ontarioHST = 0.13;
	var peiHST = 0.14;
	// GST only Terrotories
	var northwestTerritoriesGST = 0.05;
	var nunavutGST = 0.05;
	var yukonGST = 0.05;

	// Setup the on change function for page refresh to reset the cart
	$(function () {
	    $('.quantity_for_sum').change();
		$('#order_prov_state').change();
		$('.product').stop(true, true);
	});

	// Setup the on change function for the country dropdown selector
	$('#order_country').change(function() {
		$('#order_prov_state').change();
	});

	// Setup the on change functions for the delivery method dropdown selectors
	$('.in_store_delivery_method').change(function() {
		$('.quantity_for_sum').change();
		$('.product').stop(true, true);
	});
	$('.shipping_delivery_method').change(function() {
		$('.quantity_for_sum').change();
		$('.product').stop(true, true);
	});

	// Setup the on change function for the unit dropdown selector
	$('.quantity_for_sum').change(function() {
	 	$('#order_prov_state').change();

	 	var subTotal = 0;
	 	var productName = '';

		$('.product_items').each(function() {
		   	$this = $(this);
			var price = +$this.find('#product_price').data('price');

			if ($this.find('.in_store_delivery_method').prop('checked')) {
				var shipping_method_selected = $this.find('.in_store_delivery_method').val();
			} else {
				var shipping_method_selected = $this.find('.shipping_delivery_method').val();
			}

  			$this.find('.quantity_for_sum').each(function() {
  				if (+this.value !== 0) {
					productName += '<h4>' + $this.find('#product_name').data('name') + '</h4> <p>' + ' (' + '$' + price.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,') + ')' + '</p>' + '<p>' + shipping_method_selected + '</p>';
					return false;
  				}
  			 });



			// Add quantity, size and colour to string productName
			$this.find('.quantity_for_sum').each(function() {
				subTotal += +this.value * price;
				var dataSize = this.parentNode.getAttribute('data-size');
				var dataColour = this.parentNode.getAttribute('data-colour');
				if (+this.value !== 0) {
					if (dataSize !== 'n/a' && dataColour !== 'n/a') {
						productName += '<p>' + dataSize + ', ' + dataColour + ' X ' + +this.value + '</p>';
					} else if (dataSize == 'n/a' && dataColour !== 'n/a') {
						productName += '<p>' + dataColour + ' X ' + +this.value + '</p>';
					} else if (dataSize !== 'n/a' && dataColour == 'n/a') {
						productName += '<p>' + dataSize + ' X ' + +this.value + '</p>';
					} else if (dataSize == 'n/a' && dataColour == 'n/a') {
						productName += '<p>' + ' X ' + +this.value + '</p>';
					}
				}
			});
		});

		// Set the html for the subtotal
		$('.sub_total').html('$' + subTotal.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));

		if (productName !== '') {
			$('.product').html(productName).effect('highlight', {color:'#006dcc'}, 2000);
		} else {
			$('.product').html(productName);
		}
	});

	// Setup the on change function for the prov/state dropdown selector. This will caluculate shipping and tax based on customer's location
	$('#order_prov_state').change(function() {
		$thisOrderProv = this;

		var e = document.getElementById('order_country');
		var $custCountry = e.options[e.selectedIndex].text;
		var totalShipping = 0;
		var TotalProductPrice = 0;
		var total_tax = 0;

		$('.product_items').each(function() {
			$this = $(this);

			// Calculate shipping factors
			if ($custCountry != 'Canada'){
				var shipping_location_factor = 1.5;
			} else {
				var shipping_location_factor = 1;
			}

			if ($this.find('.in_store_delivery_method').prop('checked')) {
				var shipping_method_factor = 0;
			} else {
				var shipping_method_factor = 1;
			}

			var shipping = +$this.find('#product_shipping').data('shipping') * shipping_location_factor * shipping_method_factor;
			var price = +$this.find('#product_price').data('price');
			var merchProv = $this.find('#merchant_state_prov').data('prov');

			// Calculate Tax
			// We must also apply local tax if picking up in store
			if ($this.find('.in_store_delivery_method').prop('checked')) {
				$custProv = $this.find('#merchant_state_prov').data('prov');
			} else {
				$custProv = $thisOrderProv.value;
			}

			// Customer and Merchant in same non-HST jurisdiction
			if ($custProv == 'Alberta' && merchProv == 'Alberta') {
				var tax_rate = (albertaGST + albertaPST);
			} else if ($custProv == 'British Columbia' && merchProv == 'British Columbia') {
				var tax_rate = bcGST + bcPST;
			} else if ($custProv == 'Manitoba' && merchProv == 'Manitoba') {
				var tax_rate = manitobaGST + manitobaPST;
			} else if ($custProv == 'Quebec' && merchProv == 'Quebec') {
				var tax_rate = quebecGST + quebecPST;
			} else if ($custProv == 'Saskatchewan' && merchProv == 'Saskatchewan') {
				var tax_rate = saskGST + saskPST;
			// Customer in non-HST jurisdiction, and different from Merchant
			} else if ($custProv == 'Alberta' && merchProv != 'Alberta') {
				var tax_rate = albertaGST;
			} else if ($custProv == 'British Columbia' && merchProv != 'British Columbia') {
				var tax_rate = bcGST;
			} else if ($custProv == 'Manitoba' && merchProv != 'Manitoba') {
				var tax_rate = manitobaGST;
			} else if ($custProv == 'Quebec' && merchProv != 'Quebec') {
				var tax_rate = quebecGST;
			} else if ($custProv == 'Saskatchewan' && merchProv != 'Saskatchewan') {
				var tax_rate = saskGST;
			// Customer in HST jurisdiction
			} else if ($custProv == 'New Brunswick' || $custProv == 'Newfoundland and Labrador' || $custProv == 'Ontario') {
				var tax_rate = 0.13;
			} else if ($custProv == 'Nova Scotia') {
				var tax_rate = novaScotiaHST;
			} else if ($custProv == 'Prince Edward Island') {
				var tax_rate = peiHST;
			// Customer in Territories
			}  else if ($custProv == 'Northwest Territories' || $custProv == 'Nunavut' || $custProv == 'Yukon') {
				var tax_rate = 0.05;
			// Customer is outside of Canada
			} else {
				var tax_rate = 0;
			}

			$this.find('.quantity_for_sum').each(function() {
				totalShipping += +this.value * shipping;
				total_tax += +this.value * (price + shipping) * tax_rate;
				TotalProductPrice += +this.value * (price + shipping) * (tax_rate+1);
			});
		});

		$('.total_shipping').html('$' + totalShipping.toFixed(2));
		$('.sales_tax_total').html('$' + total_tax.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
		$('.total_order_amount').html('<b>' + '$' + TotalProductPrice.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") + '</b>');

		$('#hiddenTax').val(total_tax);
		$('#hiddenShipping').val(totalShipping);
		$('#finalTotal').val(TotalProductPrice);

		if($custProv == '') {
			$('#order_total_calculation').hide(1000);
			$('.total_placeholder').show(1000);
		} else {
			$('.total_placeholder').hide(1000);
			$('#order_total_calculation').show(1000);
		}
	});

	// Prevent typing in number to unit input
	$("[type='number']").keypress(function (evt) {
	    evt.preventDefault();
	});

	// Show comments form and hide unit selections form
	$('.show_comments_form_button').click(function() {
		var parObj = $(this).closest('.product_items');
		parObj.find('.quantity_and_shipping_form').fadeOut();
		parObj.find('.show_comments_form_button').fadeOut();
		parObj.find('.merchant_comments_form').delay(400).fadeIn();
		parObj.find('.hide_comments_form_button').delay(400).fadeIn();
	});
	$('.hide_comments_form_button').click(function() {
		var parObj = $(this).closest('.product_items');
		parObj.find('.merchant_comments_form').fadeOut();
		parObj.find('.hide_comments_form_button').fadeOut();
		parObj.find('.quantity_and_shipping_form').delay(400).fadeIn();
		parObj.find('.show_comments_form_button').delay(400).fadeIn();
	});

	// Toggle add to cart tab
	$(document).on('click', '.toggle_sizes', function() {
		 $(this).next(".size_selections").slideToggle();
	});
	$(document).on('click', '.size_details_button', function() {
		 $(this).next('.size_details').slideToggle();
	});

	// Storedropdown selections for session
	$('.quantity_for_sum').each(function() {
		if (sessionStorage.getItem($(this).data('unit'))) {
			this.value = sessionStorage.getItem($(this).data('unit'));
		}
		$(this).change(function() {
			sessionStorage.setItem($(this).data('unit'), this.value);
		});
	});
});
