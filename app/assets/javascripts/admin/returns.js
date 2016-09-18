$(document).ready(function(){
  $('#suggested_refund_amounts').hide();
  $('#show_default_fields').hide();
  var $submitButton = $("#refund_submit");
  var qtyOrdered = $('#quantity_ordered').data('quantity');
  var orderUnitSubtotal = $('#default_subtotal').data('subtotal')/qtyOrdered;
  var orderUnitShipping = $('#default_shipping_charge').data('shipping')/qtyOrdered;
  var orderUnitSalesTax = $('#default_sales_tax').data('salestax')/qtyOrdered;
  var taxRate = $('#tax_rate').data('taxrate');
  var freightTaxable = $('#freight_taxable').data('freight');

  $('.refund_select').change(function(event) {
        var qtyReturned = this.value;
        var defaultSubTotal = orderUnitSubtotal*qtyReturned;
        var defaultShipping = 0.00;
        var defaultSalesTax = defaultSubTotal*taxRate;
        // var defaultSalesTax = orderUnitSalesTax*qtyReturned;
        var defaultTotal = defaultSubTotal+defaultShipping+defaultSalesTax;

        $('#default_subtotal').html('$' + defaultSubTotal.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
        $('#default_shipping_charge').html('$' + defaultShipping.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
        $('#default_sales_tax').html('$' + defaultSalesTax.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
        $('#default_total').html('$' + defaultTotal.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
        if ($('#suggested_refund_amounts').is(":visible")) {
          calculateSum();
        } else {
          $("#refund_submit").val('Refund ' + "$"+defaultTotal.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
        }
    });

    $(".suggested_amount").each(function() {
			$(this).keyup(function(){
				calculateSum();
			});
		});
    function calculateSum() {

		var sum = 0;
		//iterate through each textboxes and add the values
		$(".suggested_amount").each(function() {

			//add only if the value is number
			if(!isNaN(this.value) && this.value.length!=0) {
				sum += parseFloat(this.value);
			}

		});
		//.toFixed() method will roundoff the final sum to 2 decimal places
		$("#suggested_total").html('$' + sum.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
    $("#refund_submit").val('Refund ' + "$"+sum.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
	}

   $('#show_suggest_fields').click(function(){
     $('#default_refund_amounts').hide();
     $('#show_suggest_fields').hide();
     $('#suggested_refund_amounts').fadeIn();
     $('#show_default_fields').fadeIn();
     calculateSum();
   });
   $('#show_default_fields').click(function(){
     $('#return_suggested_sub_total').val('0.00');
     $('#return_suggested_sales_tax').val('0.00');
     $('#return_suggested_shipping_charge').val('0.00');
     $("#suggested_total").html('$' + '0.00');
     $('#suggested_refund_amounts').delay().hide();
     $('#show_default_fields').hide();
     $('#show_suggest_fields').fadeIn();
     $('#default_refund_amounts').fadeIn();
     $('.refund_select').change();
   });


});
