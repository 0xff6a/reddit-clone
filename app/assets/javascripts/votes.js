$(document).ready( function(){

	console.log('Hi')

	$('.up-vote-link').on('click', function() {
		event.preventDefault();
		var voteCount = $(this).siblings('.vote-count');
		
		$.post(this.href, function(response){
			voteCount.text(response.new_vote_count);
		});

	});

});
