class RepliesController < ApplicationController

	def new
		@comment = Comment.find(params[:comment_id])
		@new_reply_comment = Comment.new()
	end

	def create
		@comment = Comment.find(params[:comment_id])
		@reply_comment = Comment.create(params[:comment].permit(:text))
		@reply_comment.parent_id = @comment.id
		@reply_comment.user_id = current_user.id
		@reply_comment.save
		redirect_to post_comments_path(@comment.post)
	end

end
