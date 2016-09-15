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
