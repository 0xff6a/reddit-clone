class Vote < ActiveRecord::Base

	belongs_to :user
	belongs_to :post

	validates :value, numericality: { message: 'Value must be a number' }
	validates :value, inclusion: { in: [1,-1], message: 'Value must be either +1 or -1' }
	validates :user_id, presence: { message: 'You must be signed in to vote'}
	validates :post_id, presence: { message: 'A vote must be assigned to a post'}

end
