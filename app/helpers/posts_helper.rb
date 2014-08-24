module PostsHelper

	def post_owner(post)
		post.user ? post.user.email : 'anonymous'
	end

end
