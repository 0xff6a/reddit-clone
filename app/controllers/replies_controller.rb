class RepliesController < ApplicationController

	def new
		@comment = Comment.find(params[:comment_id])
		@new_reply_comment = Comment.new()
	end

	def create
		@comment = Comment.find(params[:comment_id])
		@reply_comment = _create_reply(@comment, params[:comment])
		@reply_comment.save ? _process_valid_reply(@comment) : _reply_errorhandler(@reply_comment, @comment)
	end

	def _create_reply(parent,data_hash)
		reply = Comment.create(data_hash.permit(:text))
		reply.parent_id = parent.id
		reply.user_id = current_user.id
		reply
	end

	def _process_valid_reply(parent)
		redirect_to post_comments_path(parent.parent_post_id)
	end

	def _reply_errorhandler(reply, parent)
		flash[:errors] = reply.errors.messages
		redirect_to post_comments_path(parent.parent_post_id)
	end

end
