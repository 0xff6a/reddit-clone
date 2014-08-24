$(document).ready( function(){

	$('.up-vote-link').on('click', function() {
		event.preventDefault();
		var voteCount = $(this).siblings('.vote-count');
		
		$.post(this.href, function(response){
			voteCount.text(response.new_vote_count);
		});

	});

	$('.down-vote-link').on('click', function() {
		event.preventDefault();
		var voteCount = $(this).siblings('.vote-count');
		
		$.post(this.href, function(response){
			voteCount.text(response.new_vote_count);
		});

	});

});
