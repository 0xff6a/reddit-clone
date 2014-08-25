class PostsController < ApplicationController

	def index
		@algorithm = :default
		@posts = Post.ranked_by_algorithm(@algorithm)
	end

	def fresh
		@algorithm = :fresh
		_display_page_for(@algorithm)
	end

	def controversial
		@algorithm = :controversial
		_display_page_for(@algorithm)
	end

	def rising
		@algorithm = :rising
		_display_page_for(@algorithm)
	end

	def new
		@type = params[:type]
		@new_post = Post.new()
	end

	def search
		@posts = Post.where("lower(title) like ?", "%#{params[:query].downcase}%").ranked_by_algorithm(@algorithm)
		render 'index'
	end

	def create
		@post = _create_post(params[:post])
		@post.save ? _process_valid_post : _post_errorhandler(@post)
	end

	def _display_page_for(algo)
		@posts = Post.ranked_by_algorithm(algo)
		render 'index'
	end

	def _create_post(data_hash)
		post = Post.create(data_hash.permit(:title, :text, :url))
		post.user_id = current_user.id
		post
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
