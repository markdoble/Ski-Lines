(function(){jQuery(function(){var t;return t=$("#user_state_prov").html(),$("#user_country").change(function(){var e,r;return r=$("#user_country :selected").text(),e=$(t).filter("optgroup[label='"+r+"']").html(),e?$("#user_state_prov").html(e):$("#user_state_prov").empty()})})}).call(this);