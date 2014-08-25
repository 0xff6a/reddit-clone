$(document).ready( function(){

	$('.up-vote-link').on('click', function() {
		event.preventDefault();
		processVoteEvent(this.href, $(this).siblings('.vote-count'));
	});

	$('.down-vote-link').on('click', function() {
		event.preventDefault();
		processVoteEvent(this.href, $(this).siblings('.vote-count'));
	});

	function processVoteEvent(url, voteCount) {	
		$.post(url, function(response){
			if( response.new_vote_count === 'error'){
				location.reload();
			} else {
				voteCount.text(response.new_vote_count);
			};
		});
	};

});
