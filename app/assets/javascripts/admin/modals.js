//******************************************************************************
// Category Select and Filter Modal Section
//
// Contains all of the methods and handlers for functionality of the elements
// within the category select and filter modals
//******************************************************************************
$(function() {
  // Click handler for the cancel link
  $('#href_cancel_category_modal').click(function( event ) {
    // Prevent the default href link behaviour
    event.preventDefault();

    // Hide the modal window
    $('#modal_category_select').modal('toggle');
  });

  // Add change handler to the root category select as it is enabled on modal window load
  addChangeHandler('category_select_0');

  // Hidden handler for the modal window. This function is executed when the modal is dismissed
  // Modal dismissal method is irrelevant as this is executed everytime the modal is dismissed/hidden
  $('#modal_category_select').on('hidden.bs.modal', function ( event ) {
    // Clear the modal window contents and reset it to the defaults
    clearModalContent();
  });

  // Click hanlder for the save button
  $('#btn_category_modal_save').click(function( event ) {
    // Update the selected category display on the product create/edit form with the contents of what is selected in the modal
    $('#product_form_category_display').html($('#div_selected_categories').text());
    // Update the category_id hidden field on the product create/edit form with the selected category_id in the modal
    $('#category_id').val($('#hidden_category_modal_category_id').val());
    // Close the modal window
    $('#modal_category_select').modal('toggle');
  });

  // Click hanlder for the filter button
  $('#btn_category_modal_filter').click(function( event ) {
    var filter_category_id = $('#hidden_category_modal_category_id').val();

    // If the user has selected a valid category, we will reload the page with the correct filter
    if (filter_category_id > 0) {
      // Add the category_id to the href before redirecting
      $(this).attr('href', $(this).attr('href') + '?category_id=' + filter_category_id);
    }
    else {
      // No valid category has been chosen, we will prevent the href link
      event.preventDefault();
    }

    // Close the modal window
    $('#modal_category_select').modal('toggle');
  });
});

// Clears the content selections of the modal window and resets all elements to their defaults
function clearModalContent() {
  // Loop through all of the select elements and remove them
  // Loop goes to 50, but will break as soon as no more select elements are found
  for (i = 1; i <= 50; i++) {
    // Check to see if the category select element exists
    if($('#category_select_' + i).length) {
      // Element exists, we will remove it and the associated selected category span
      $('#category_select_' + i).remove();
      $('#span_selected_category_' + i).remove();
    }
    else {
      // Element does not exist. We've reached the end of our elements. Break out of the for loop
      break;
    }
  }

  // Set the defaults for the elements that remain displayed
  $('#category_select_0').val('0');
  $('#span_selected_category_0').html('None Selected');
  $('#hidden_category_modal_category_id').val('');
  $('#btn_category_modal_save').addClass('disabled');
}

// Adds the change handler to the element that matches the ID passed in as a parameter
// This function was needed to be able to bind the change event after dynamic creation of new select elements
function addChangeHandler(element_id) {
  // Bind the change function
  $('#' + element_id).change(function( event ) {
    // Retrieve the current category ID
    var cur_category_id = $(this).val();

    // Get the current number of the select element and the next number in the sequence.
    // Parsed from the ID as the ID format is category_select_XXXX
    var cur_select_num = parseInt($(this).attr('id').substr($(this).attr('id').lastIndexOf("_") + 1));
    var next_select_num = cur_select_num + 1;

    // Loop through all of the select elements and remove all of then that have a higher number than the current select
    // Loop goes to 50, but will break as soon as no more select elements are found
    for (i = next_select_num; i <= 50; i++) {
      // Check to see if the category select element exists
      if($('#category_select_' + i).length) {
        // Element exists, we will remove it and the associated selected category span
        $('#category_select_' + i).remove();
        $('#span_selected_category_' + i).remove();
      }
      else {
        // Element does not exist. We've reached the end of our elements. Break out of the for loop
        break;
      }
    }

    // Update the selected caterory display to show a breadcrumb trail of the category tree
    if(cur_category_id > 0) {
      // Set the category separator to use. Do not add the separator if this is the root category
      var category_separator = ' > ';
      if (cur_select_num == 0) {
        category_separator = '';
      }

      // Check to see if the category span already exists
      if($('#span_selected_category_' + cur_select_num).length) {
        // The span exists, we will simply update its html
        $('#span_selected_category_' + cur_select_num).html(category_separator + $('option:selected',this).text());
      }
      else {
        // The span does not exist, we will create it and append it to the selected categories div
        $('#div_selected_categories').append('<span id="span_selected_category_' + cur_select_num + '">' + category_separator + $('option:selected',this).text() + '</span>');
      }
    }
    else {
      // Remove the spans when necessary
      if($('#span_selected_category_' + cur_select_num).length) {
        $('#span_selected_category_' + cur_select_num).remove();
      }
    }

    // Make the ajax call to the controller to get the listing of subcategories given a parent category
    $.ajax({
        type: 'post',
        url: '/categories/update_subcategories.json',
        dataType: 'json',
        data: {
          parent_id: cur_category_id
        },
        success: function(data) {
          // Check to see if we have subcategories. If we do, we will create and append the select box to our subcategory div
          if(data.length > 0) {
            // Determine the select name and id to use
            var select_identifier = 'category_select_' + next_select_num;

            // Determine the margin size to indent the neste dropdowns
            var margin_size = next_select_num * 10;

            // Create the select element and add the default value
            $('#div_subcategories').append('<select class="subcategory_modal_select" style="margin-left: ' + margin_size + 'px;" name="' + select_identifier + '" id="' + select_identifier + '">');
            $('#' + select_identifier).append('<option value="0">-- Select --</option>');

            // Loop through all of the options (subcategories) add. They will be built and added to the select element
            $.each(data, function(index, element) {
              $('#' + select_identifier).append('<option value="' + element.id + '">' + element.name + '</option>');
            });

            // Add the change handlers to the newly added select element
            addChangeHandler(select_identifier);
          }

          // Logic to enable/disable the save button. We do not allow choosing a category if it has subcategories
          if(data.length > 0 || cur_category_id == 0) {
            $('#btn_category_modal_save').addClass('disabled');
          }
          else {
            $('#btn_category_modal_save').removeClass('disabled');
          }

          // Set the hidden input field for the category_id
          $('#hidden_category_modal_category_id').val(cur_category_id);
        }
      });
  });
}
