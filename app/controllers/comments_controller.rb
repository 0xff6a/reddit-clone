class CommentsController < ApplicationController

	def index
		@post = Post.find(params[:post_id])
		@new_comment = Comment.new
		@comments = Comment.find_by(post_id: params[:post_id])
	end

	def create
		@comment = _create_comment(params[:comment], params[:post_id])
		@comment.save ? _process_valid_comment(params[:post_id]) : _comment_errorhandler(@comment, params[:post_id])
	end

	def _create_comment(data_hash, post_id)
		comment = Comment.create(data_hash.permit(:text))
		comment.post_id = post_id
		comment.user_id = current_user.id
		comment
	end

	def _process_valid_comment(post_id)
		flash[:notice] = 'Your comments have been noted...'
		redirect_to post_comments_path(post_id)
	end

	def _comment_errorhandler(comment, post_id)
		flash[:errors] = comment.errors.messages
		redirect_to post_comments_path(post_id)
	end

end
