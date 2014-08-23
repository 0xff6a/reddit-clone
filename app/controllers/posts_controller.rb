class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def new
		@new_post = Post.new()
	end

	def create
		@post = Post.create(params[:post].permit(:title, :text))
		@post.valid? ? _process_valid_post : _post_errorhandler(@post)
	end

	def _process_valid_post
		flash[:notice] = 'Thank you for posting...'
		redirect_to posts_path
	end
	
	def _post_errorhandler(post)
		flash[:errors] = post.errors.messages
		redirect_to posts_path
	end

end
