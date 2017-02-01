$(document).ready(function(){

  // Change event for the integration type select
  $('#integration_type_select').change(function() {
    // will have to be modified once we add more integration types.
    // At time of implementation, only Lightspeed Retail exists.
    if ($(this).val() > 0) {
      $('#lightspeed_retail').show();
    }
    else {
      $('#lightspeed_retail').hide();
    }
  });
  
});
