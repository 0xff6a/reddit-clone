class Post < ActiveRecord::Base

	validates :title, presence: { message:'Your post must have a title' }

end
