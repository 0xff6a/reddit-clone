class CommentsController < ApplicationController

	def new
		@post = Post.find(params[:post_id])
		@new_comment = Comment.new
	end

	def create
		@comment = _create_comment(params[:comment], params[:post_id])
		@comment.save
		flash[:notice] = 'Your comments have been noted...'
		redirect_to posts_path
	end

	def _create_comment(data_hash, post_id)
		comment = Comment.create(data_hash.permit(:text))
		comment.post_id = post_id
		comment
	end

end
