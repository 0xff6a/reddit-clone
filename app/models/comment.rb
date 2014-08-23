class Comment < ActiveRecord::Base

	belongs_to 	:post
	belongs_to 	:user

	validates 	:user_id, presence: { message: 'You must be signed in to comment'	}
	validates 	:post_id, presence: { message: 'You must comment a post' 					}
	validates 	:text, 		presence: { message: 'Your comment must have text'			}

end
