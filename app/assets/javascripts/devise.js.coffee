jQuery ->
	categories = $('#user_state_prov').html();
	
	$('#user_country').change ->
		sub_category = $('#user_country :selected').text();
		options = $(categories).filter("optgroup[label='#{sub_category}']").html()
		if options
			$('#user_state_prov').html(options)
		else
			$('#user_state_prov').empty();

