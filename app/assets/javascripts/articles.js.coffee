jQuery ->
	$(window).scroll ->
		url = $('.pagination .next_page').attr('href');
		if url && $(window).scrollTop() > $(document).height() - $(window).height() - 200
			$('.pagination').text("One second...We're finding you more great articles...");
			$.getScript(url);
	$('.articles').scroll();
