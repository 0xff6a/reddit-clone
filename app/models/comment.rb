class Comment < ActiveRecord::Base

	belongs_to 	:post
	belongs_to 	:user
	has_many		:comments

	validates 	:user_id, presence: { message: 'You must be signed in to comment'	}
	validates 	:text, 		presence: { message: 'Your comment must have text'			}
	validate    :has_parent_post_or_comment

	before_save :set_parent_post_id

	def replies
		Comment.where(parent_id: _comment.id)
	end

	def find_parent_post_id
		return post_id if post_id.present?
		Comment.find(parent_id).parent_post_id
	end

	def self.count_if_parent_id(search_id)
		Comment.where(parent_post_id: search_id).count
	end

	private

	def has_parent_post_or_comment
		if parent_id.present? && post_id.present?
			_both_present_errorhandler
		elsif !parent_id.present? && !post_id.present?
			_neither_present_errorhandler
		end
	end

	def _both_present_errorhandler
		errors.add(:post_id, 'Your comment cannot reference both a post and a comment')
		errors.add(:parent_id, 'Your comment cannot reference both a post and a comment')
	end

	def _neither_present_errorhandler
		errors.add(:post_id, 'Your comment must reference a post or a comment')
		errors.add(:parent_id, 'Your comment must reference a post or a comment')
	end

	def _comment
		self
	end

	protected

	def set_parent_post_id
    self.parent_post_id = self.find_parent_post_id
  end

end
