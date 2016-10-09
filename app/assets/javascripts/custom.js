/*
 * Function to be executed once the DOM has been fully loaded and ready
 * Contains component initializing and click handlers
 */
$(document).ready(function(){

	// Initialize fancybox
	$('a.fancybox').fancybox();

	// Setup click events for article descriptions
	$(document).on('click', '.article_description', function() {
		 $(this).toggleClass('article_description article_description_full');
	});
	$(document).on('click', '.article_description_full', function() {
		 $(this).toggleClass('article_description_full article_description');
	});

	// Setup click event for the forgot password toggle
	$(document).on('click', '.rest_password_button', function() {
		 $(this).next('.reset_password').slideToggle();
	});

	// Setup click event for the product category toggle
	$(document).on('click', '.product_category', function() {
		 $(this).next('.product_subcategory').slideToggle();
	});

	// Smooth scrolling
	$(function() {
		$('.checkout_button').click(function() {
			if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
				var target = $(this.hash);
				target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
				if (target.length) {
					$('html,body').animate({scrollTop: target.offset().top}, 1000);
					return false;
				}
			}
		});
	});

});


/*
 * Function to be executed once the DOM has been fully loaded and ready
 * Contains file upload initialization
 */
$(document).ready(function(){
    var preview = $('.upload-preview img');

	// Setup the change event for the file
    $('.file').change(function(event) {
		var input = $(event.currentTarget);
		var file = input[0].files[0];
		var reader = new FileReader();

		reader.onload = function(e) {
			image_base64 = e.target.result;
			preview.attr('src', image_base64);
		};
		reader.readAsDataURL(file);
    });
});

/*
 * Function to be executed once the DOM has been fully loaded and ready
 * Contains creation of the new unit form
 */
$(document).ready(function() {
	// Elements that are initially hidden
	$('.diff_col').hide();
	$('.units_button').hide();

	// Setup the change events
	$('#size_true').change(function() {
		if ($('#size_true').is(':checked')) {
			$('.diff_col').fadeIn();
		}
	});
	$('#size_false').change(function() {
		if ($('#size_false').is(':checked')) {
			$('.diff_col').fadeIn();
		}
	});

	$('#colours_false').change(function() {
		$('.units_button').fadeIn();
	});
	$('#colours_true').change(function() {
		$('.units_button').fadeIn();
	});

	// Setup the click event
	$('.create_unit_form').click(function() {
		$('.old_unit_form').fadeOut();
		if ($('#size_true').is(':checked')) {
			if ($('#colours_false').is(':checked')) {
				$('.new_form_sizes_inventory').delay(1000).fadeIn(1000);
			}
			else if ($('#colours_true').is(':checked')) {
				$('.new_form_sizes_colours_inventory').delay(1000).fadeIn(1000);
			}
		}
		else if ($('#size_false').is(':checked')) {
			if ($('#colours_true').is(':checked')) {
				$('.new_form_colours_inventory').delay(1000).fadeIn(1000);
			}
			else if ($('#colours_false').is(':checked')) {
				$('.new_form_units_inventory').delay(1000).fadeIn(1000);
			}
		}
	});

	// Devise: Duplicating form field for slug/vanity url
	$('#user_merchant_name').keyup(function() {
		$('#user_slug').val(this.value.replace(/\W/g, ''));
	});


	// New Article Form logic

	// Setup click events
	$('.create_reproduced_content_form').click(function() {
		$('.new_article_button_1').fadeOut();
		$('#reproduced_content_form').delay(400).fadeIn();
	});
	$('.create_original_content_form').click(function() {
		$('.new_article_button_1').fadeOut();
		$('#original_content_form').delay(400).fadeIn();
	});
	$('.create_facebook_video_form').click(function() {
		$('.new_article_button_1').fadeOut();
		$('#facebook_video_form').delay(400).fadeIn();
	});
	$('.create_youtube_video_form').click(function() {
		$('.new_article_button_1').fadeOut();
		$('#youtube_video_form').delay(400).fadeIn();
	});

	$('.create_user_poll_form').click(function(){
		$('.new_article_button_1').fadeOut();
		$('#user_poll_form').delay(400).fadeIn();
	});
	// Setup keyup event
	$('.reproduced_new_article_location').keyup(function(){
		/* Add article source url */
		document.getElementById('article_source').value = this.value.replace(/(\/\/[^\/]+)?\/.*/, '$1').replace('https://', "").replace("http://", '').replace("www.", "");


		// Add article date
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1; //We add +1 as getMonth() is zero based
		var yyyy = today.getFullYear();

		// Add a leading 0 if the day is less than 10
		if(dd < 10) {
		    dd = '0' + dd;
		}

		// Add a leading 0 if the month is less than 10
		if(mm < 10) {
		    mm = '0' + mm;
		}

		// Concatenate the date in the desird format and set it to the required element
		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById('article_date_published').value = today;
	});

	// Prevent double email_digest form submission
	$('#new_email_digest').submit(function() {
		$("input[type='submit']", this).val('Please Wait...');
		$("input[type='submit']", this).attr('disabled', 'disabled');
		return true;
	});
});
