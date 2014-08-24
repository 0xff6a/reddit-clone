class Post < ActiveRecord::Base

	belongs_to 	:user
	has_many 		:comments
	has_many 		:votes

	validates 	:title, presence: { message:'Your post must have a title' }
	validate 		:contains_text_or_url, message: 'Your post must include text or a link'
	validates 	:user_id, presence: { message:'You must be signed in to post' }
	validate		:url_format_if_present, message: 'Not a valid url format'

	def vote_total
		[_post.votes.sum(:value), 0].max
	end

	def rank
		Post.all.sort_by(&:vote_total).reverse.index(_post) + 1
	end

	private

	def contains_text_or_url
		unless url.present? || text.present? 
			errors.add(:text, 'Your post must include text or a link')
			errors.add(:url, 'Your post must include text or a link')
		end
	end

	def url_format_if_present
		if url.present?
			errors.add(:url, 'Not a valid url format') unless url =~ URI::regexp
		end
	end

	def _post
		self
	end

end
