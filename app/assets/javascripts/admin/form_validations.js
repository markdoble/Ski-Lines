//***********************************************************************************************
// Product Form validations
//***********************************************************************************************

// Validation for the product create/edit form
function validateProductForm() {
  // Check to make sure a category has been chosen
  if($('#category_id').val() == 0) {
    alert('Error: You must select a category.');
    return false;
  }

  // Return true if all validations pass
  return true;
}

//***********************************************************************************************
// Merchant Form validations
//***********************************************************************************************

// Validation for the merchant create/edit form
function validateMerchantForm() {
  // Set the result to true by default
  var result = true;

  // Reset all of the fields
  $('.lbl_required').hide();
  $('.input_required').removeClass('input_required');

  // Validate the required merchant name
  if(!$('#user_merchant_name').val()) {
    $('#user_merchant_name').addClass('input_required');
    $('#lbl_user_merchant_name_required').show();
    result = false;
  }

  // Validate the required phone number if it exists
  if($('#user_merchant_phone').length && !$('#user_merchant_phone').val()) {
    $('#user_merchant_phone').addClass('input_required');
    $('#lbl_user_merchant_phone_required').show();
    result = false;
  }

  // Validate the required first name
  if(!$('#user_contact_first_name').val()) {
    $('#user_contact_first_name').addClass('input_required');
    $('#lbl_user_contact_first_name_required').show();
    result = false;
  }

  // Validate the required last name
  if(!$('#user_contact_last_name').val()) {
    $('#user_contact_last_name').addClass('input_required');
    $('#lbl_user_contact_last_name_required').show();
    result = false;
  }

  // Validate the required user email
  if(!$('#user_email').val()) {
    $('#user_email').addClass('input_required');
    $('#lbl_user_email_required').show();
    $('#lbl_user_email_error').show();
    result = false;
  }
  else {
    // We have a value, we will validate that it is a proper email address
    if(!isValidEmailAddress($('#user_email').val())) {
      $('#user_email').addClass('input_required');
      $('#lbl_user_email_invalid').show();
      $('#lbl_user_email_error').show();
      result = false;
    }
  }

  // Validate the required street address
  if(!$('#user_street_address').val()) {
    $('#user_street_address').addClass('input_required');
    $('#lbl_user_street_address_required').show();
    result = false;
  }

  // Validate the required country
  if(!$('#user_country').val()) {
    $('#user_country').addClass('input_required');
    $('#lbl_user_country_required').show();
    result = false;
  }

  // Validate the required state/prov
  if(!$('#user_state_prov').val()) {
    $('#user_state_prov').addClass('input_required');
    $('#lbl_user_state_prov_required').show();
    result = false;
  }

  // Validate the required city
  if(!$('#user_city').val()) {
    $('#user_city').addClass('input_required');
    $('#lbl_user_city_required').show();
    result = false;
  }

  // Validate the required zip/postal
  if(!$('#user_zip_postal').val()) {
    $('#user_zip_postal').addClass('input_required');
    $('#lbl_user_zip_postal_required').show();
    result = false;
  }

  // Validate the required return policy if it exists
  if($('#user_user_return_policy').length && !$('#user_user_return_policy').val()) {
    $('#user_user_return_policy').addClass('input_required');
    $('#lbl_user_user_return_policy_required').show();
    result = false;
  }

  // Validate the required CAD domestic shipping fee if it exists
  if($('#user_cad_domestic_shipping').length && !$('#user_cad_domestic_shipping').val()) {
    $('#user_cad_domestic_shipping').addClass('input_required');
    $('#lbl_user_cad_domestic_shipping_required').show();
    result = false;
  }

  // Validate the required CAD foreign shipping fee if it exists
  if($('#user_cad_foreign_shipping').length && !$('#user_cad_foreign_shipping').val()) {
    $('#user_cad_foreign_shipping').addClass('input_required');
    $('#lbl_user_cad_foreign_shipping_required').show();
    result = false;
  }

  // Validate the required USD domestic shipping fee if it exists
  if($('#user_usd_domestic_shipping').length && !$('#user_usd_domestic_shipping').val()) {
    $('#user_usd_domestic_shipping').addClass('input_required');
    $('#lbl_user_usd_domestic_shipping_required').show();
    result = false;
  }

  // Validate the required USD foreign shipping fee if it exists
  if($('#user_usd_foreign_shipping').length && !$('#user_usd_foreign_shipping').val()) {
    $('#user_usd_foreign_shipping').addClass('input_required');
    $('#lbl_user_usd_foreign_shipping_required').show();
    result = false;
  }

  // Validate the required shipping country selections
  if($('input:checkbox[id^="user_country_ids_"]:checked').length == 0) {
    $('#user_shipping_country').addClass('input_required');
    $('#lbl_user_shipping_country_required').show();
    result = false;
  }

  // Validate the password. Validation is different for the create/edit forms
  if($('#user_merchant_edit_reset_password').length) {
    // We are on the create form. Only verify if they are provided and if they match
    if($('#user_password').val() && $('#user_password_confirmation').val()) {
      if($('#user_password').val() != $('#user_password_confirmation').val()) {
        $('#user_password_confirmation').addClass('input_required');
        $('#lbl_user_password_confirmation_invalid').show();
        $('#lbl_user_password_confirmation_error').show();
        result = false;
      }
    }
  }
  else {
    // We are on the create form. Verify that they are entered and they match
    // Validate the required password
    if(!$('#user_password').val()) {
      $('#user_password').addClass('input_required');
      $('#lbl_user_password_required').show();
      result = false;
    }

    // Validate the required password confirmation
    if(!$('#user_password_confirmation').val()) {
      $('#user_password_confirmation').addClass('input_required');
      $('#lbl_user_password_confirmation_required').show();
      $('#lbl_user_password_confirmation_error').show();
      result = false;
    }
    else {
      // We have a value, we will make sure it matches the password field
      if($('#user_password').val() != $('#user_password_confirmation').val()) {
        $('#user_password_confirmation').addClass('input_required');
        $('#lbl_user_password_confirmation_invalid').show();
        $('#lbl_user_password_confirmation_error').show();
        result = false;
      }
    }
  }

  // Validate the required current password if it exists
  if($('#user_current_password').length && !$('#user_current_password').val()) {
    $('#user_current_password').addClass('input_required');
    $('#lbl_user_current_password_required').show();
    result = false;
  }

  //Show the error header and focus on it if we have errors
  if(!result) {
    $('#div_error_header').show();
    window.scroll(0,0);
  }

  // Return the final result. True will indicate no errors and false indicates errors
  return result;
}


// Initiate focus and change handlers to reset/hide the error messages when a user attempts to correct the issue
$(document).ready(function() {
  // Merchant name focus
  $('#user_merchant_name').focus(function() {
    $('#user_merchant_name').removeClass('input_required');
    $('#lbl_user_merchant_name_required').hide();
  });

  // Merchant phone focus
  $('#user_merchant_phone').focus(function() {
    $('#user_merchant_phone').removeClass('input_required');
    $('#lbl_user_merchant_phone_required').hide();
  });

  // Merchant first name focus
  $('#user_contact_first_name').focus(function() {
    $('#user_contact_first_name').removeClass('input_required');
    $('#lbl_user_contact_first_name_required').hide();
  });

  // Merchant last name focus
  $('#user_contact_last_name').focus(function() {
    $('#user_contact_last_name').removeClass('input_required');
    $('#lbl_user_contact_last_name_required').hide();
  });

  // Merchant email focus
  $('#user_email').focus(function() {
    $('#user_email').removeClass('input_required');
    $('#lbl_user_email_required').hide();
    $('#lbl_user_email_invalid').hide();
    $('#lbl_user_email_error').hide();
  });

  // Street address focus
  $('#user_street_address').focus(function() {
    $('#user_street_address').removeClass('input_required');
    $('#lbl_user_street_address_required').hide();
  });

  // Country focus
  $('#user_country').focus(function() {
    $('#user_country').removeClass('input_required');
    $('#lbl_user_country_required').hide();
    $('#user_state_prov').removeClass('input_required');
    $('#lbl_user_state_prov_required').hide();
  });

  // State/Prov focus
  $('#user_state_prov').focus(function() {
    $('#user_state_prov').removeClass('input_required');
    $('#lbl_user_state_prov_required').hide();
  });

  // City focus
  $('#user_city').focus(function() {
    $('#user_city').removeClass('input_required');
    $('#lbl_user_city_required').hide();
  });

  // Zip/Postal focus
  $('#user_zip_postal').focus(function() {
    $('#user_zip_postal').removeClass('input_required');
    $('#lbl_user_zip_postal_required').hide();
  });

  // User return policy focus
  $('#user_user_return_policy').focus(function() {
    $('#user_user_return_policy').removeClass('input_required');
    $('#lbl_user_user_return_policy_required').hide();
  });

  // User CAD domestic shipping focus
  $('#user_cad_domestic_shipping').focus(function() {
    $('#user_cad_domestic_shipping').removeClass('input_required');
    $('#lbl_user_cad_domestic_shipping_required').hide();
  });

  // User CAD foreign shipping focus
  $('#user_cad_foreign_shipping').focus(function() {
    $('#user_cad_foreign_shipping').removeClass('input_required');
    $('#lbl_user_cad_foreign_shipping_required').hide();
  });

  // User USD domestic shipping focus
  $('#user_usd_domestic_shipping').focus(function() {
    $('#user_usd_domestic_shipping').removeClass('input_required');
    $('#lbl_user_usd_domestic_shipping_required').hide();
  });

  // User USD foreign shipping focus
  $('#user_usd_foreign_shipping').focus(function() {
    $('#user_usd_foreign_shipping').removeClass('input_required');
    $('#lbl_user_usd_foreign_shipping_required').hide();
  });

  // Shipping country change
  $('input:checkbox[id^="user_country_ids_"]').change(function() {
    $('#user_shipping_country').removeClass('input_required');
    $('#lbl_user_shipping_country_required').hide();
  });

  // Password focus
  $('#user_password').focus(function() {
    $('#user_password').removeClass('input_required');
    $('#lbl_user_password_required').hide();
  });

  // Password confirmation focus
  $('#user_password_confirmation').focus(function() {
    $('#user_password_confirmation').removeClass('input_required');
    $('#lbl_user_password_confirmation_required').hide();
    $('#lbl_user_password_confirmation_invalid').hide();
    $('#lbl_user_password_confirmation_error').hide();
  });

  // Current password focus
  $('#user_current_password').focus(function() {
    $('#user_current_password').removeClass('input_required');
    $('#lbl_user_current_password_required').hide();
  });
});

//***********************************************************************************************
// Order Validation Functions
//***********************************************************************************************

// Validation for the cart form
function validateCartForm() {
  // We will check to see if any products have been selected
  if($('#cart_products').html().length == 0) {
    // No products have been selected, we will show the error div and scroll to the top of the page
    $('#cart_products_error').show();
    window.scroll(0,0);

    // Return false to indicate an error
    return false;
  }

  // Return true to indicate no errors were found
  return true;
}

// Initializations that are needed
$(document).ready(function() {
  // Click handler for the error div
  $('#cart_products_error_dismiss').click(function(event) {
    $('#cart_products_error').hide();
  });
});

//***********************************************************************************************
// Customer Details Validation Functions
//***********************************************************************************************

// Validaton for the customer order details form
function validateCustomerDetailsForm() {
  // Set the result to true by default
  var result = true;

  // Reset all of the fields
  $('.lbl_required').hide();
  $('.input_required').removeClass('input_required');
  $('.input_select_required').removeClass('input_select_required');
  $('#customer_details_error').hide();
  $('#customer_details_email_error').hide();

  // Validate the customer first name
  if(!$('#order_cust_first_name').val()) {
    $('#order_cust_first_name').addClass('input_required');
    result = false;
  }

  // Validate the customer last name
  if(!$('#order_cust_last_name').val()) {
    $('#order_cust_last_name').addClass('input_required');
    result = false;
  }

  // Validate the customer email
  if(!$('#order_cust_email').val()) {
    $('#order_cust_email').addClass('input_required');
    result = false;
  }
  else {
    // We have a value, we will validate that it is a proper email address
    if(!isValidEmailAddress($('#order_cust_email').val())) {
      $('#order_cust_email').addClass('input_required');
      $('#customer_details_email_error').show();
      result = false;
    }
  }

  // Validate the customer email confirmation
  if(!$('#order_cust_email_confirmation').val()) {
    $('#order_cust_email_confirmation').addClass('input_required');
    result = false;
  }
  else {
    // We have a value, we will make sure it matches the password field
    if($('#order_cust_email').val() != $('#order_cust_email_confirmation').val()) {
      $('#order_cust_email_confirmation').addClass('input_required');
      $('#customer_details_email_error').show();
      result = false;
    }
  }

  // Validate the customer street address
  if(!$('#order_street_address').val()) {
    $('#order_street_address').addClass('input_required');
    result = false;
  }

  // Validate the customer city
  if(!$('#order_city').val()) {
    $('#order_city').addClass('input_required');
    result = false;
  }

  // Validate the customer postal/zip
  if(!$('#order_postal_zip').val()) {
    $('#order_postal_zip').addClass('input_required');
    result = false;
  }

  // Validate the customer country
  if(!$('#order_country').val()) {
    $('#order_country').addClass('input_select_required');
    result = false;
  }

  // Validate the customer province/state
  if(!$('#order_prov_state').val()) {
    $('#order_prov_state').addClass('input_select_required');
    result = false;
  }

  // If we have errors, we will show the error div
  if(!result) {
    $('#customer_details_error').show();
    window.scroll(0,0);
  }

  // Return the result of the form validation
  return result;
}

// Initializations that are needed
$(document).ready(function() {
  // Click handler for the error div
  $('#customer_details_error_dismiss').click(function(event) {
    $('#customer_details_error').hide();
  });

  // Click handler for the email error div
  $('#customer_details_email_error_dismiss').click(function(event) {
    $('#customer_details_email_error').hide();
  });

  // Customer First Name focus
  $('#order_cust_first_name').focus(function() {
    $('#order_cust_first_name').removeClass('input_required');
  });

  // Customer Last Name focus
  $('#order_cust_last_name').focus(function() {
    $('#order_cust_last_name').removeClass('input_required');
  });

  // Customer Email focus
  $('#order_cust_email').focus(function() {
    $('#order_cust_email').removeClass('input_required');
  });

  // Customer Email Confirmation focus
  $('#order_cust_email_confirmation').focus(function() {
    $('#order_cust_email_confirmation').removeClass('input_required');
  });

  // Customer Street Address focus
  $('#order_street_address').focus(function() {
    $('#order_street_address').removeClass('input_required');
  });

  // Customer City focus
  $('#order_city').focus(function() {
    $('#order_city').removeClass('input_required');
  });

  // Customer Postal/Zip focus
  $('#order_postal_zip').focus(function() {
    $('#order_postal_zip').removeClass('input_required');
  });

  // Customer Country focus
  $('#order_country').focus(function() {
    $('#order_country').removeClass('input_select_required');
  });

  // Customer Prov/State focus
  $('#order_prov_state').focus(function() {
    $('#order_prov_state').removeClass('input_select_required');
  });
});

//***********************************************************************************************
// Common Validation Functions
//***********************************************************************************************

// Function to validate an email address
function isValidEmailAddress(emailAddress) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(emailAddress);
};
