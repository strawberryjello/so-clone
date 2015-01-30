$(document).ready(function(){
  $('#js-downvote-question').on('click', function(e){
    e.preventDefault();

    var $link = $(this),
        url = $link.prop('href');

    $.ajax({
      url: url,
      type: 'post',
      success: function(votes){
        $('#js-question-votes').html(votes);
      },
      error: function(){
        alert("You already downvoted this question");
      }
    });
  });
  
});
