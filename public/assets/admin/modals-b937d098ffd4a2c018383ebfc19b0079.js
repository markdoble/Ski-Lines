function clearModalContent(){for(i=1;i<=50&&$("#category_select_"+i).length;i++)$("#category_select_"+i).remove(),$("#span_selected_category_"+i).remove();$("#category_select_0").val("0"),$("#span_selected_category_0").html("None Selected"),$("#hidden_category_modal_category_id").val(""),$("#btn_category_modal_save").addClass("disabled")}function addChangeHandler(e){$("#"+e).change(function(){var e=$(this).val(),t=parseInt($(this).attr("id").substr($(this).attr("id").lastIndexOf("_")+1)),a=t+1;for(i=a;i<=50&&$("#category_select_"+i).length;i++)$("#category_select_"+i).remove(),$("#span_selected_category_"+i).remove();if(e>0){var o=" > ";0==t&&(o=""),$("#span_selected_category_"+t).length?$("#span_selected_category_"+t).html(o+$("option:selected",this).text()):$("#div_selected_categories").append('<span id="span_selected_category_'+t+'">'+o+$("option:selected",this).text()+"</span>")}else $("#span_selected_category_"+t).length&&$("#span_selected_category_"+t).remove();$.ajax({type:"post",url:"/categories/update_subcategories.json",dataType:"json",data:{parent_id:e},success:function(t){if(t.length>0){var o="category_select_"+a,c=10*a;$("#div_subcategories").append('<select class="subcategory_modal_select" style="margin-left: '+c+'px;" name="'+o+'" id="'+o+'">'),$("#"+o).append('<option value="0">-- Select --</option>'),$.each(t,function(e,t){$("#"+o).append('<option value="'+t.id+'">'+t.name+"</option>")}),addChangeHandler(o)}t.length>0||0==e?$("#btn_category_modal_save").addClass("disabled"):($("#btn_category_modal_save").removeClass("disabled"),$("#hidden_category_modal_category_id").val(e))}})})}$(function(){$("#href_cancel_category_modal").click(function(e){e.preventDefault(),$("#modal_category_select").modal("toggle")}),addChangeHandler("category_select_0"),$("#modal_category_select").on("hidden.bs.modal",function(){clearModalContent()}),$("#btn_category_modal_save").click(function(){$("#product_form_category_display").html($("#div_selected_categories").text()),$("#category_id").val($("#hidden_category_modal_category_id").val()),$("#modal_category_select").modal("toggle")})});