class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def new
		@new_post = Post.new()
	end

	def create
		@post = Post.create(params[:post].permit(:title, :text))
		flash[:notice] = 'Thank you for posting...'
		redirect_to posts_path
	end

end
