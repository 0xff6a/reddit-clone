module CommentsHelper

	def comment_owner(comment)
		comment.user ? comment.user.email : 'anonymous'
	end

end
