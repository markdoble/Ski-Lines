$(document).ready(function(){$("a.fancybox").fancybox(),$(document).on("click",".article_description",function(){$(this).toggleClass("article_description article_description_full")}),$(document).on("click",".article_description_full",function(){$(this).toggleClass("article_description_full article_description")}),$(document).on("click",".rest_password_button",function(){$(this).next(".reset_password").slideToggle()}),$(document).on("click",".product_category",function(){$(this).next(".product_subcategory").slideToggle()}),$(function(){$(".checkout_button").click(function(){if(location.pathname.replace(/^\//,"")==this.pathname.replace(/^\//,"")&&location.hostname==this.hostname){var e=$(this.hash);if(e=e.length?e:$("[name="+this.hash.slice(1)+"]"),e.length)return $("html,body").animate({scrollTop:e.offset().top},1e3),!1}})})}),$(document).ready(function(){var e=$(".upload-preview img");$(".file").change(function(t){var n=$(t.currentTarget),c=n[0].files[0],o=new FileReader;o.onload=function(t){image_base64=t.target.result,e.attr("src",image_base64)},o.readAsDataURL(c)})}),$(document).ready(function(){$(".diff_col").hide(),$(".units_button").hide(),$("#size_true").change(function(){$("#size_true").is(":checked")&&$(".diff_col").fadeIn()}),$("#size_false").change(function(){$("#size_false").is(":checked")&&$(".diff_col").fadeIn()}),$("#colours_false").change(function(){$(".units_button").fadeIn()}),$("#colours_true").change(function(){$(".units_button").fadeIn()}),$(".create_unit_form").click(function(){$(".old_unit_form").fadeOut(),$("#size_true").is(":checked")?$("#colours_false").is(":checked")?$(".new_form_sizes_inventory").delay(1e3).fadeIn(1e3):$("#colours_true").is(":checked")&&$(".new_form_sizes_colours_inventory").delay(1e3).fadeIn(1e3):$("#size_false").is(":checked")&&($("#colours_true").is(":checked")?$(".new_form_colours_inventory").delay(1e3).fadeIn(1e3):$("#colours_false").is(":checked")&&$(".new_form_units_inventory").delay(1e3).fadeIn(1e3))}),$("#user_merchant_name").keyup(function(){document.getElementById("user_slug").value=this.value.replace(/\W/g,"")}),$(".create_reproduced_content_form").click(function(){$(".new_article_button_1").fadeOut(),$("#reproduced_content_form").delay(400).fadeIn()}),$(".create_original_content_form").click(function(){$(".new_article_button_1").fadeOut(),$("#original_content_form").delay(400).fadeIn()}),$(".create_facebook_video_form").click(function(){$(".new_article_button_1").fadeOut(),$("#facebook_video_form").delay(400).fadeIn()}),$(".create_youtube_video_form").click(function(){$(".new_article_button_1").fadeOut(),$("#youtube_video_form").delay(400).fadeIn()}),$(".create_user_poll_form").click(function(){$(".new_article_button_1").fadeOut(),$("#user_poll_form").delay(400).fadeIn()}),$(".reproduced_new_article_location").keyup(function(){document.getElementById("article_source").value=this.value.replace(/(\/\/[^\/]+)?\/.*/,"$1").replace("https://","").replace("http://","").replace("www.","");var e=new Date,t=e.getDate(),n=e.getMonth()+1,c=e.getFullYear();10>t&&(t="0"+t),10>n&&(n="0"+n),e=c+"-"+n+"-"+t,document.getElementById("article_date_published").value=e}),$("#new_email_digest").submit(function(){return $("input[type='submit']",this).val("Please Wait..."),$("input[type='submit']",this).attr("disabled","disabled"),!0})});