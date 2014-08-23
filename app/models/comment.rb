class Comment < ActiveRecord::Base

	belongs_to :post

	validates :post_id, presence: { message: 'You must be signed in to comment' }

end
