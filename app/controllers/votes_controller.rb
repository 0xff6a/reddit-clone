class VotesController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		vote = _create_vote_for(post, params)
		vote.save ? _process_valid_vote_for(post) : _vote_errorhandler(vote, post)
	end

	def _create_vote_for(post, data_hash)
		vote = post.votes.create(data_hash.permit(:value, :post_id))
		vote.user_id = current_user.id
		vote
	end

	def _process_valid_vote_for(post)
		render json: { new_vote_count: post.vote_total }
	end

	def _vote_errorhandler(vote, post)
		flash[:errors] = vote.errors.messages
		render json: { new_vote_count: 'error' }
	end

end
