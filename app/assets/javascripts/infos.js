$(document).ready(function(){
  $(document).on("click", ".question", function(event){
  event.preventDefault();
  $(this).next('.answer').slideToggle();
});
});
