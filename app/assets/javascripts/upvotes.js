$(document).ready(function(){

  $('table').on('click', 'a[class^="js-vote-button"]', function(e) {
    e.preventDefault();

    var $link = $(this),
        url = $link.prop('href'),
        voteId = '#' + $(this).parent().children('.votes-tally').attr('id');

    $.ajax({
      url: url,
      type: 'post',
      success: function(votes){
        $(voteId).html(votes);
      },
      error: function(xhr, status, error){
        alert(xhr.responseText);
      }
    });
  });
  
});
