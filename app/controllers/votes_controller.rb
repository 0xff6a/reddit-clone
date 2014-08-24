class VotesController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		vote = post.votes.create(params.permit(:value, :post_id))
		vote.user_id = current_user.id
		vote.save
		render json: { new_vote_count: post.vote_total }
	end

end
