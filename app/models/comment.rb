class Comment < ActiveRecord::Base

	belongs_to :post

	validates :post_id, presence: { message: 'You must be signed in to comment' }
	validates :text, presence: { message: 'Your comment must have text'}

end
