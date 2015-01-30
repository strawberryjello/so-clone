$(document).ready(function(){

  $('table').on('click', 'a[id^="js-upvote"]', function(e) {
    e.preventDefault();

    var $link = $(this),
        url = $link.prop('href'),
        voteId = '#' + $(this).parent().children('div').attr('id');

    $.ajax({
      url: url,
      type: 'post',
      success: function(votes){
        $(voteId).html(votes);
      },
      error: function(){
        alert('You have already upvoted');
      }
    });
  });
  
});
