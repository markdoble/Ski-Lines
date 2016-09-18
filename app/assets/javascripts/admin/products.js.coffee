jQuery ->
	categories = $('#product_product_subcategory').html();

	$('#product_product_category').change ->
		sub_category = $('#product_product_category :selected').text();
		options = $(categories).filter("optgroup[label='#{sub_category}']").html();
		if options
			$('#product_product_subcategory').html(options);
		else
			$('#product_product_subcategory').empty();

jQuery ->
	$(window).scroll ->
		url = $('.pagination .next_page').attr('href');
		if url && $(window).scrollTop() > $(document).height() - $(window).height() - 200
			$('.pagination').text("One second...We're finding more products...");
			$.getScript(url);
	$('.products').scroll();
