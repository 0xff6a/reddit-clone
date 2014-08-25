class Post < ActiveRecord::Base

	EPOCH = Time.new(2005, 12, 8)
	TIME_NORMALIZER = 45000

	belongs_to 	:user
	has_many 		:comments, dependent: :destroy
	has_many 		:votes, dependent: :destroy

	validates 	:title, presence: { message:'Your post must have a title' }
	validate 		:contains_text_or_url, message: 'Your post must include text or a link'
	validates 	:user_id, presence: { message:'You must be signed in to post' }
	validate		:url_format_if_present, message: 'Not a valid url format'

	def vote_total
		[_post.votes.sum(:value), 0].max
	end

	def rank(algorithm)
		Post.ranked_by_algorithm(algorithm).index(_post) + 1
	end

	def self.ranked_by_algorithm(algorithm)
		case algorithm
		when :default
			self.default_ranking
		when :fresh
			self.fresh_ranking
		else
			self.all
		end
	end

	def self.default_ranking
		self.all.sort_by(&:hotness).reverse
	end

	def self.fresh_ranking
		self.all.sort_by(&:created_at).reverse
	end

	def hotness
		s = _post.votes.sum(:value)
		order = Math.log([s, 1].max, 10)
		order + (_sign(s) * _age) / TIME_NORMALIZER
	end

	def descendants_count
		Comment.count_if_parent_id(_post.id)
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

	def _sign(integer)
	  return 1 if integer > 0 
	  return -1 if integer < 0
	  0
	end

	def _age
		_post.created_at - EPOCH
	end

end
