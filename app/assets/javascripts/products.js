/*
 * Function to be executed once the DOM has been fully loaded and ready
 */
$(document).ready(function(){
	// Define the click actions for all product filter toggles
	$(document).on('click', '.clothing_filter_button', function() {
		$(this).next('.clothing_filter_options').slideToggle();	 
	});
	$(document).on('click', '.hg_filter_button', function() {
		 $(this).next('.hg_filter_options').slideToggle();	 
	});
	$(document).on('click', '.wax_filter_button', function() {
		 $(this).next(".wax_filter_options").slideToggle();	 
	});
	$(document).on('click', '.acc_filter_button', function() {
		 $(this).next(".acc_filter_options").slideToggle();	 
	}); 
});
