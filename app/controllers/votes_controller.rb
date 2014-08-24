class VotesController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		vote = _create_vote_for(post, params)
		render json: { new_vote_count: post.vote_total }
	end

	def _create_vote_for(post, data_hash)
		vote = post.votes.create(data_hash.permit(:value, :post_id))
		vote.user_id = current_user.id
		vote.save
	end

end
