class Post < ActiveRecord::Base

	validates :title, presence: { message:'Your post must have a title' }
	validate :contains_text_or_url, message: 'Your post must include text or a link'

	def contains_text_or_url
		unless url.present? || text.present? 
			errors.add(:text, 'Your post must include text or a link')
			errors.add(:url, 'Your post must include text or a link')
		end
	end

end
