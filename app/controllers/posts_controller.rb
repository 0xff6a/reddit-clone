class PostsController < ApplicationController

	def index

	end

	def new
		@new_post = Post.new()
	end

	def create
		@post = Post.create(params[:post].permit(:title, :text))
		redirect_to posts_path
	end

end
